import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { Router } from '@angular/router';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  MinLengthValidator,
  MinValidator,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { DestinosService } from '../../../servicios/existencias/destinos.service';
import { Destinos } from '../../../modelos/existencias/destinos.model';
import { Pedidos } from '../../../modelos/existencias/pedidos.model';
import { PedidosService } from '../../../servicios/existencias/pedidos.service';
import { ArticulosService } from '../../../servicios/existencias/articulos.service';
import Swal from 'sweetalert2';
import { ArtixpedidoService } from '../../../servicios/existencias/artixpedido.service';
import { min } from 'rxjs';

@Component({
  selector: 'app-add-pedido.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './add-pedido.component.html',
  styleUrl: './add-pedido.component.css',
})
export class AddPedidoComponent implements OnInit {
  formPedido!: FormGroup;
  formArticulo!: FormGroup;
  _articulos: any[] = [];
  _articulosSelected: any[] = [];
  _documentos: Documentos[] = [];
  _beneficiarios: Beneficiarios[] = [];
  _destinos: Destinos[] = [];
  documento: string = '';
  date: Date = new Date();
  articulo!: string;
  _suggestions: string[] = [];
  _suggestMap = new Map<string, Articulos>();

  constructor(
    public authService: AutorizaService,
    private router: Router,
    private fb: FormBuilder,
    private documentoService: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private pedidoService: PedidosService,
    private artService: ArticulosService,
    private artixpedidoService: ArtixpedidoService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/pedidos');
    let coloresJSON = sessionStorage.getItem('/pedidos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    this.formPedido = this.fb.group({
      numero: [
        0,
        [
          Validators.required,
          Validators.min(1),
          Validators.pattern(/^[1-9]\d*$/), // Solo números enteros positivos
        ],
      ],
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      documento: [''],
      fecha: [this.date.toISOString().substring(0, 10), [Validators.required]],
      descripcion: ['', [Validators.required]],
      total: 0.00,
      feccrea: [this.date],
      usucrea: [this.authService.idusuario],
      beneficiarioText: ['', [Validators.required]],
      destinoText: ['', [Validators.required]],
      beneficiario: [null],
      destino: [null],
    });
    this.formArticulo = this.fb.group({
      articulo: [''],
    });

    this.getAllDocumentos();
    this.getAllDestinos();
    this.getLastPedido();
    this.calcularTotal();
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }
  get f() {
    return this.formPedido.controls;
  }
  regresar() {
    this.router.navigate(['/pedidos']);
  }
  async guardar() {
    if (this.formPedido.invalid) {
      this.authService.mostrarError(
        'Formulario incompleto',
        'Por favor llena todos los campos requeridos.'
      );
      this.formPedido.markAllAsTouched();
      return;
    }

    const f = this.formPedido.value as Pedidos;

    // Crear el objeto pedido correctamente tipado
    const pedidoData: Pedidos = new Pedidos();
    Object.assign(pedidoData, {
      numero: f.numero,
      fecha: f.fecha,
      total: +f.total!,
      descripcion: f.descripcion,
      usucrea: f.usucrea,
      feccrea: f.feccrea,
      numdoc: f.numdoc,
      documento: f.documento,
      beneficiario: f.beneficiario,
      destino: f.destino,
    });

    try {
      // Esperar la respuesta del backend (usa await si el servicio devuelve una Promise)
      const nuevoPedido = await this.pedidoService.savePedido(pedidoData);
      // Ahora guarda los artículos relacionados al pedido
      for (const art of this._articulosSelected) {
        const articuloPedido = {
          pedido: nuevoPedido,
          articulo: art,
          cantidad: art.cantidad,
          usucrea: this.authService.idusuario,
          feccrea: new Date(),
        };
        this.artixpedidoService
          .save(articuloPedido)
          .then(() => {})
          .catch((error) => {
            console.error('Error al guardar artículo para el pedido: ', error);
          });
      }

      this.swal('success', 'Pedido guardado correctamente.');

      // Limpia el formulario y el listado de artículos seleccionados
      this.formPedido.reset();
      this.regresar();
      this.getLastPedido();
      this._articulosSelected = [];
    } catch (error: any) {
      this.authService.mostrarError('Error', error?.error || 'No se pudo guardar el pedido.');
    }
  }
  getLastPedido() {
    this.pedidoService.getLastPedido().subscribe({
      next: (data: number) => {
        this.formPedido.patchValue({ numero: data + 1 });
      },
    });
  }
  getAllDocumentos() {
    this.documentoService.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        this._documentos = data;
        this.formPedido.patchValue({
          documento: data[0],
        });
      },
      error: (e) => {
        this.authService.mostrarError('error', e.error);
      },
    });
  }
  getAllDestinos() {
    this.destService.getListaDestinos().subscribe({
      next: (data: Destinos[]) => {
        this._destinos = data;
      },
      error: (e) => {
        this.authService.mostrarError('error', e.error);
      },
    });
  }
  getArticulos(ev: any) {
    let term = (ev.target.value || '').trim();
    if (term.includes('|')) term = term.split('|')[0].trim();
    if (!term) {
      this._articulos = [];
      this._suggestions = [];
      this._suggestMap.clear();
      return;
    }

    this.artService.getByNombreCuentaCodigo(term).subscribe({
      next: (arts: Articulos[]) => {
        this._articulos = arts;

        this._suggestMap.clear();
        for (const a of arts) {
          const nombre = a.nombre?.trim();
          const codigo = a.codigo != null ? String(a.codigo).trim() : '';
          const codcue = a.codcue != null ? String(a.codcue).trim() : '';

          for (const s of [codigo, codcue, nombre].filter(Boolean)) {
            const label = `${s} | ${a.nombre}`; // lo que se muestra y matchea al inicio
            if (!this._suggestMap.has(label)) this._suggestMap.set(label, a);
          }
        }

        // genera el arreglo para el *ngFor del datalist
        this._suggestions = Array.from(this._suggestMap.keys());
      },
      error: (e) => this.authService.mostrarError('error', e.error),
    });
  }
  onArticuloSelected(ev: any) {
    const key = (ev.target.value || '').trim(); // ej: "ABC123 | Tijera 6''" o "5.2.01 | Tijera 6''" o "Tijera 6'' | ABC123"
    const art = this._suggestMap.get(key);

    if (art) {
      // evita duplicados por id
      const ya = this._articulosSelected.some(
        (x) => String(x.idarticulo) === String(art.idarticulo)
      );
      if (!ya) this._articulosSelected.push({ ...art, cantidad: 1 });

      // limpia input y sugerencias
      this.formArticulo.get('articulo')?.setValue('');
      this._suggestions = [];
      this._suggestMap.clear();
    } else {
      // fallback: intenta matchear por la parte antes del " | "
      const head = key.split('|')[0]?.trim();
      const maybe = this._articulos.find(
        (a) => a.nombre === head || String(a.codigo) === head || String(a.codcue) === head
      );
      if (maybe) {
        const ya = this._articulosSelected.some(
          (x) => String(x.idarticulo) === String(maybe.idarticulo)
        );
        if (!ya) this._articulosSelected.push({ ...maybe, cantidad: 1 });
        this.formArticulo.get('articulo')?.setValue('');
      }
    }
    this.calcularTotal();
  }
  getAllBeneficiarios(query: string, onLoaded?: (lista: Beneficiarios[]) => void) {
    const nombreVal = (query || '').toString().trim();
    if (!nombreVal) {
      this._beneficiarios = [];
      onLoaded?.([]);
      return;
    }

    this.beneService.findByNomben(nombreVal).subscribe({
      next: (data: Beneficiarios[]) => {
        this._beneficiarios = data || [];
        onLoaded?.(this._beneficiarios);
      },
      error: (e) => {
        this._beneficiarios = [];
        this.authService.mostrarError('error', e?.error || 'Error consultando beneficiarios');
        onLoaded?.([]);
      },
    });
  }
  onBeneficiarioTyped(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    // limpia el objeto si el usuario sigue tecleando
    this.formPedido.patchValue({ beneficiario: null });
    this.getAllBeneficiarios(raw, (lista) => {
      // intenta atar automáticamente si el texto coincide exactamente con un nombre
      const bene = lista.find((b) => (b.nomben || '').toLowerCase() === key) || null;
      if (bene) {
        this.formPedido.patchValue({
          beneficiario: bene,
          beneficiarioText: bene.nomben,
        });
      }
    });
  }
  onBeneficiarioSelected(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    let bene = this._beneficiarios?.find((b) => (b.nomben || '').toLowerCase() === key) || null;
    if (!bene) {
      this.getAllBeneficiarios(raw, (lista) => {
        const b = lista.find((x) => (x.nomben || '').toLowerCase() === key) || null;
        this.formPedido.patchValue({
          beneficiario: b,
          beneficiarioText: b ? b.nomben : raw, // deja lo escrito si no encontró
        });
        this.formPedido.get('beneficiario')?.markAsTouched();
      });
      return;
    }

    // si lo encontró en la lista actual
    this.formPedido.patchValue({
      beneficiario: bene,
      beneficiarioText: bene.nomben,
    });
    this.formPedido.get('beneficiario')?.markAsTouched();
  }
  onDestinoTyped(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    this.formPedido.patchValue({ destino: dest });
  }
  onDestinoSelected(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    if (dest) {
      this.formPedido.patchValue({
        destino: dest,
        destinoText: dest.nomdestino,
      });
    } else {
      this.formPedido.patchValue({ destino: null });
    }
    this.f['destino'].markAsTouched();
  }
  setArticulosToList(art: any) {
    if (!this._articulosSelected.find((a) => a.idarticulo === art.idarticulo)) {
      this._articulosSelected.push({ ...art, cantidad: 1 });
      this.calcularTotal();
    } else {
      this.swal('info', 'El artículo ya está en la lista');
    }
    this.formArticulo.reset();
    //this._articulos = []; // opcional: limpia sugerencias
  }
  removeArticulo(index: number) {
    this._articulosSelected.splice(index, 1);
    this.calcularTotal();
  }
  validarCantidad(art: any) {
    if (art.cantidad < 1) {
      art.cantidad = 1;
    } else if (art.cantidad > art.actual) {
      art.cantidad = art.actual;
    }
    this.calcularTotal();
  }
  calcularTotal() {
    let total: number = 0;
    if (this._articulosSelected.length > 0) {
      this._articulosSelected.forEach((art: any) => {
        total += art.cantidad * art.cosactual;
      });
    }
    this.formPedido.patchValue({ total: total.toFixed(2) });
  }
  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top',
      showConfirmButton: false,
      timer: 2000,
    });
  }
  numAvailable(event: any) {
    const num = event.target.value;
    if (!num) return;

    this.pedidoService.getNumAvailable(+num!).subscribe({
      next: (disponible: boolean) => {
        const numeroControl = this.formPedido.get('numero');

        if (!disponible) {
          // Si NO está disponible, marcamos error personalizado
          numeroControl?.setErrors({ notAvailable: true });
        } else {
          // Si está disponible, quitamos el error (si lo tenía)
          if (numeroControl?.hasError('notAvailable')) {
            numeroControl.setErrors(null);
          }
        }
      },
      error: (err) => {
        console.error('Error verificando número:', err);
      },
    });
  }
}

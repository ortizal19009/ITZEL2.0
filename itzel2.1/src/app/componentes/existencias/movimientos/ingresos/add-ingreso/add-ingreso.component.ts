import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { Documentos } from '../../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../../servicios/administracion/documentos.service';
import { Destinos } from '../../../../modelos/existencias/destinos.model';
import { Beneficiarios } from '../../../../modelos/contabilidad/beneficiarios.model';
import { BeneficiariosService } from '../../../../servicios/contabilidad/beneficiarios.service';
import { DestinosService } from '../../../../servicios/existencias/destinos.service';
import { MovimientoService } from '../../../../servicios/existencias/movimiento.service';
import { Movimientos } from '../../../../modelos/existencias/movimientos.model';
import { Articulos } from '../../../../modelos/existencias/articulos.model';
import { ArticulosService } from '../../../../servicios/existencias/articulos.service';
import { ArtimoviService } from '../../../../servicios/existencias/artimovi.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-ingreso.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './add-ingreso.component.html',
  styleUrl: './add-ingreso.component.css',
})
export class AddIngresoComponent implements OnInit {
  formMovimiento!: FormGroup;
  formArticulo!: FormGroup;
  today: Date = new Date();
  _documentos: Documentos[] = [];
  _destinos: Destinos[] = [];
  _beneficiarios: Beneficiarios[] = [];
  tipmov: number = 1; // DEFIMIR MOVIMIENTOS DE INGRESO
  _articulos: any[] = [];
  _suggestions: string[] = [];
  _suggestMap = new Map<string, Articulos>();
  _articulosSelected: any[] = [];

  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private s_documentos: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private movService: MovimientoService,
    private artService: ArticulosService,
    private artimoviService: ArtimoviService
  ) { }
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/mov-ingresos');
    this.getAllDocumentos();
    this.getAllDestinos();
    this.getLastNumeroMovimiento();
    let coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    this.formMovimiento = this.fb.group({
      numero: [
        0,
        [
          Validators.required,
          Validators.min(1),
          Validators.pattern(/^[1-9]\d*$/), // Solo enteros positivos
        ],
      ],
      fecha: [this.today.toISOString().substring(0, 10), [Validators.required]],
      // 👇 corregido: todos los sync validators al 2º argumento
      numentrada: ['', [Validators.required, Validators.minLength(2)]],
      total: [''],
      numart: [''],
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      documento: [''],
      fecdoc: [this.today.toISOString().substring(0, 10), [Validators.required]],
      swaprobado: [false],
      beneficiarioText: ['', [Validators.required]],
      destinoText: ['', [Validators.required]],
      beneficiario: [null, Validators.required],
      destino: [null, Validators.required],
      compegre: ['', Validators.required],
      observaciones: [''],
    });
    this.formArticulo = this.fb.group({
      articulo: [''],
    });
    this.calcularTotal();
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
    this.formMovimiento = this.fb.group({});
  }
  get f() {
    return this.formMovimiento.controls;
  }
  guardar() {
    let movimiento: Movimientos = new Movimientos();
    let f = this.formMovimiento.value;
    console.log(f);
    movimiento.tipmov = this.tipmov;
    movimiento.numero = f.numero;
    movimiento.fecha = f.fecha;
    movimiento.numentrada = f.numentrada;
    movimiento.total = 0;
    movimiento.numart = 0;
    movimiento.documento = f.documento;
    movimiento.numdoc = f.numdoc;
    movimiento.fecdoc = f.fecdoc;
    movimiento.swaprobado = f.swaprobado;
    movimiento.beneficiario = f.beneficiario;
    movimiento.destino = f.destino;
    movimiento.compegre = f.compegre;
    movimiento.observaciones = f.observaciones;
    movimiento.feccrea = new Date();
    movimiento.usucrea = this.authService.idusuario;
    console.log('MOVIMIENTO A GUARDAR: ', movimiento);
    this.movService.saveMovimientoAsync(movimiento).then((movimientoGuardado) => {
      console.log('MOVIMIENTO GUARDADO: ', movimientoGuardado);
      console.log('ARTICULOS A GUARDAR: ', this._articulosSelected);
      let cantidad = 0;
      if (this._articulosSelected && this._articulosSelected.length > 0) {
        for (let art of this._articulosSelected){
          cantidad += art.cantidad;
        }
        //cantidad += this._articulosSelected.cantidad;
      }
      const artimovi: any = {
        tipmov: this.tipmov,
        total: f.total,
        usucrea: this.authService.idusuario,
        feccrea: new Date(),
        idmovimiento: movimientoGuardado,
        articulos: this._articulosSelected,
        cantidad: cantidad,
        cosprom: 0,
        usmodi: 0,
        fecmodi: null,
      };

      /**
    -private short tipmov;
    -private float cantidad;
    -private BigDecimal total;
    private BigDecimal cosprom;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;
    private Movimientos movimiento;
    private List<Articulos> articulos;
       *
       */
      this.artimoviService.saveArtimoviAsync(artimovi).then((artimoviGuardado) => {
        console.log('ARTICULOS GUARDADOS: ', artimoviGuardado);
        this.swal(
          'success',
          `El ingreso N° ${movimientoGuardado.numero} se ha guardado correctamente.`
        );
        this.regresar();
      });
    });
  }
  regresar() {
    this.router.navigate(['/mov-ingresos']);
  }
  numAvailable(event: any) {
    console.log('VERIFICANDO SI EL NÚMERO ESTA DISPONIBLE ', event.target.value);
    const num = event.target.value;
    if (!num) return;

    this.movService.getNumAvailable(this.tipmov, +num!).subscribe({
      next: (disponible: boolean) => {
        const numeroControl = this.formMovimiento.get('numero');

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


  getLastNumeroMovimiento() {
    this.movService.findUltimo(this.tipmov).subscribe({
      next: (data: number) => {
        console.log(data);
        this.formMovimiento.patchValue({
          numero: data + 1,
        });
      },
    });
  }
  getAllDocumentos() {
    this.s_documentos.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        this._documentos = data;
        this.formMovimiento.patchValue({
          documento: data[0],
        });
      },
      error: (e) => console.error(e.error),
    });
  }
  onDestinoTyped(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    this.formMovimiento.patchValue({ destino: dest });
  }
  onDestinoSelected(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    if (dest) {
      this.formMovimiento.patchValue({
        destino: dest,
        destinoText: dest.nomdestino,
      });
    } else {
      this.formMovimiento.patchValue({ destino: null });
    }
    this.f['destino'].markAsTouched();
  }
  onBeneficiarioTyped(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    // limpia el objeto si el usuario sigue tecleando
    this.formMovimiento.patchValue({ beneficiario: null });
    this.getAllBeneficiarios(raw, (lista) => {
      // intenta atar automáticamente si el texto coincide exactamente con un nombre
      const bene = lista.find((b) => (b.nomben || '').toLowerCase() === key) || null;
      if (bene) {
        setTimeout(() => {
          this.formMovimiento.patchValue({
            beneficiario: bene,
            beneficiarioText: bene.nomben,
          });
        });
      }
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
  onBeneficiarioSelected(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    let bene = this._beneficiarios?.find((b) => (b.nomben || '').toLowerCase() === key) || null;
    if (!bene) {
      this.getAllBeneficiarios(raw, (lista) => {
        const b = lista.find((x) => (x.nomben || '').toLowerCase() === key) || null;
        this.formMovimiento.patchValue({
          beneficiario: b,
          beneficiarioText: b ? b.nomben : raw, // deja lo escrito si no encontró
        });
        this.formMovimiento.get('beneficiario')?.markAsTouched();
      });
      return;
    }

    // si lo encontró en la lista actual
    this.formMovimiento.patchValue({
      beneficiario: bene,
      beneficiarioText: bene.nomben,
    });
    this.formMovimiento.get('beneficiario')?.markAsTouched();
  }
  getAllBeneficiarios(query: string, onLoaded?: (lista: Beneficiarios[]) => void): void {
    const nombreVal = query?.trim();

    // 🟡 Validación temprana: si no hay texto, limpiamos la lista
    if (!nombreVal) {
      this._beneficiarios = [];
      onLoaded?.([]);
      return;
    }

    this.beneService.findByPrefixAndNombre('P', nombreVal).subscribe({
      next: (data: Beneficiarios[] = []) => {
        console.log(data);
        this._beneficiarios = Array.isArray(data) ? data : [];
        onLoaded?.(this._beneficiarios);
      },
      error: (error) => {
        this._beneficiarios = [];
        // Si tienes un servicio de alertas, puedes habilitar esta línea:
        // this.authService.mostrarError('Error', error?.error || 'No se pudieron cargar los beneficiarios');
        onLoaded?.([]);
      },
      complete: () => {
        console.debug('ℹ️ Consulta de beneficiarios finalizada.');
      },
    });
  }
  /* OPCIONES PARA BUSCAR Y GENERAR ARTICULOS */
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
    console.log(ev.target.value);
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
  calcularTotal() {
    let total: number = 0;
    if (this._articulosSelected.length > 0) {
      this._articulosSelected.forEach((art: any) => {
        total += art.cantidad * art.cosactual;
      });
    }
    this.formMovimiento.patchValue({ total: total.toFixed(2) });
  }
  validarCantidad(art: any) {
    if (art.cantidad < 1) {
      art.cantidad = 1;
    } else if (art.cantidad > art.actual) {
      art.cantidad = art.actual;
    }
    this.calcularTotal();
  }
  removeArticulo(index: number) {
    this._articulosSelected.splice(index, 1);
    this.calcularTotal();
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
}

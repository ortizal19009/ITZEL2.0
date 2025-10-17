import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { Router } from '@angular/router';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { CommonModule } from '@angular/common';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
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
import { debounceTime, distinctUntilChanged, filter, map, tap } from 'rxjs';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-pedido.component',
  imports: [CommonModule, ReactiveFormsModule, VisualFormatDirective, FormsModule],
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

  constructor(
    public authService: AutorizaService,
    private router: Router,
    private fb: FormBuilder,
    private documentoService: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private pedidoService: PedidosService,
    private artService: ArticulosService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/pedidos');
    let coloresJSON = sessionStorage.getItem('/articulos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    this.formPedido = this.fb.group({
      numero: [''],
      numdoc: [''],
      documento: [''],
      fecha: this.date.toISOString().substring(0, 10),
      beneficiario: [''],
      total: ['0.00'],
      descripcion: [''],
      feccrea: [this.date],
      usucrea: [this.authService.idusuario],
      destino: [''],
    });
    this.formArticulo = this.fb.group({
      articulo: [''],
    });

    this.getAllDocumentos();
    this.getAllDestinos();
    this.getLastPedido();
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
  guardar() {
    console.log(this.formPedido.value);
    console.log(this._articulosSelected);
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
  getAllBeneficiarios(nombre: any) {
    let nombreVal = nombre.target.value;
    this.beneService.findByNomben(nombreVal).subscribe({
      next: (data: Beneficiarios[]) => {
        this._beneficiarios = data;
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
  // Llama a tu servicio mientras se escribe (si quieres mantenerlo así)
  _suggestions: string[] = [];
  _suggestMap = new Map<string, Articulos>();

  getArticulos(ev: any) {
    let term = (ev.target.value || '').trim();
    // si viene del datalist, quedará "CODIGO | Nombre" o "CODCUE | Nombre"
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

  // Se ejecuta cuando el usuario elige un valor del datalist (o pierde foco tras escribir uno)
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
  }

  setArticulosToList(art: any) {
    if (!this._articulosSelected.find((a) => a.idarticulo === art.idarticulo)) {
      this._articulosSelected.push({ ...art, cantidad: 1 });
    } else {
      this.swal('info', 'El artículo ya está en la lista');
    }
    this.formArticulo.reset(); // limpia el input
    //this._articulos = []; // opcional: limpia sugerencias
  }

  removeArticulo(index: number) {
    this._articulosSelected.splice(index, 1);
  }

  onDocumentoSelected(event: any) {}
  artxPedido(event: any) {}

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

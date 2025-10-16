import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';

@Component({
  selector: 'app-add-pedido.component',
  imports: [CommonModule, ReactiveFormsModule, VisualFormatDirective],
  templateUrl: './add-pedido.component.html',
  styleUrl: './add-pedido.component.css',
})
export class AddPedidoComponent implements OnInit {
  formPedido!: FormGroup;
  _articulos: Articulos[] = [];
  _documentos: Documentos[] = [];
  _beneficiarios: Beneficiarios[] = [];
  documento: string = '';
  date: Date = new Date();
  constructor(
    public authService: AutorizaService,
    private router: Router,
    private fb: FormBuilder,
    private documentoService: DocumentosService,
    private beneService: BeneficiariosService
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
    this.getAllDocumentos();
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
  }
  getAllDocumentos() {
    this.documentoService.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        console.log(data);
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
        console.log(data);
        this._beneficiarios = data;
      },
      error: (e) => {
        this.authService.mostrarError('error', e.error);
      },
    });
  }
  getAllDestinos() {}

  onDocumentoSelected(event: any) {}
  artxPedido(event: any) {}
}

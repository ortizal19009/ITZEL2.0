import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';

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
  documento: string = '';
  constructor(
    public authService: AutorizaService,
    private router: Router,
    private fb: FormBuilder
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
    });
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
  onDocumentoSelected(event: any) {}
  artxPedido(event: any) {}
}

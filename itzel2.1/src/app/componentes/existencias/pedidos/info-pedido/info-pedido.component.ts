import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-info-pedido.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './info-pedido.component.html',
  styleUrl: './info-pedido.component.css',
})
export class InfoPedidoComponent implements OnInit {
  constructor(public authService: AutorizaService) {}
  ngOnInit(): void {
    sessionStorage.setItem('ventana', '/pedidos');
    let coloresJSON = sessionStorage.getItem('/pedidos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }
}

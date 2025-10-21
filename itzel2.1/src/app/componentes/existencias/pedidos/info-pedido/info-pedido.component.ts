import { Component, OnInit } from '@angular/core';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PedidosService } from '../../../servicios/existencias/pedidos.service';
import { ArtixpedidoService } from '../../../servicios/existencias/artixpedido.service';
import { ArticulosService } from '../../../servicios/existencias/articulos.service';
@Component({
  selector: 'app-info-pedido',
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './info-pedido.component.html',
  styleUrls: ['./info-pedido.component.css'],
})
export class InfoPedidoComponent implements OnInit {
  pedido: any = { articulos: [], total: 0 };

  constructor(
    public authService: AutorizaService,
    private pedidoService: PedidosService,
    private artxpedidService: ArtixpedidoService
  ) {}

  ngOnInit(): void {
    sessionStorage.setItem('ventana', '/pedidos');

    const idpedidoStr = sessionStorage.getItem('infoToPedido');
    if (!idpedidoStr) {
      console.error('No se encontró idpedido en sessionStorage');
      return;
    }
    const idpedido = Number(idpedidoStr);

    const coloresJSON = sessionStorage.getItem('/pedidos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    this.getPedidoById(idpedido);
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');

    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  getPedidoById(idpedido: number) {
    this.pedidoService.getPedidoById(idpedido).subscribe({
      next: (data: any) => {
        console.log('Pedido recibido:', data);
        this.pedido = { ...data, articulos: [], total: 0 };

        // Llamada asíncrona para obtener los artículos del pedido
        this.artxpedidService
          .getByIdPedidoAsync(idpedido)
          .then((items: any[]) => {
            console.log('Artículos del pedido:', items);
            this.pedido.articulos = items;
            // this.calcularTotal();
          })
          .catch((error) => console.error('Error cargando artículos del pedido:', error));
      },
      error: (e: any) => console.error('Error cargando pedido:', e.error || e),
    });
  }

  calcularTotal() {
    if (!this.pedido?.articulos) return;
    this.pedido.total = this.pedido.articulos.reduce((sum: number, art: any) => {
      console.log(art);

      sum + (art.cantidad || 0) * (art.articulo.cosactual || 0), 0;
    });
  }

  cancelar() {
    console.log('Cancelar pedido');
  }

  aprobarPedido() {
    console.log('Aprobar pedido');
  }
}

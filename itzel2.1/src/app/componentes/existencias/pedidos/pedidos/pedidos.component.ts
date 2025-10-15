import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Pedidos } from '../../../modelos/existencias/pedidos.model';

@Component({
  selector: 'app-pedidos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './pedidos.component.html',
  styleUrl: './pedidos.component.css',
})
export class PedidosComponent implements OnInit {
  formBuscar!: FormGroup;
  txtbuscar: string = 'Buscar';
  swbuscando?: boolean;
  _pedidos: any[] = [];
  pedidosFiltrados: Pedidos[] = [];
  ordenColumna: keyof PedidosVisual = 'numero';
  ordenAscendente: boolean = true;
  sumTotal: number = 0;
  constructor(public fb: FormBuilder, private router: Router) {}
  ngOnInit(): void {
    this.formBuscar = this.fb.group({
      codigo: '',
      codcue: '',
      nombre: '',
      filtroControl: '',
    });
  }
  buscar() {}
  nuevo() {
    this.router.navigate(['/add-pedido']);
  }
  imprimir() {}
  cerrar() {
    this.router.navigate(['/inicio']);
  }

  filtrar(valor: any): void {
    const filtro = String(valor).toLowerCase();
    if (!filtro) {
      this.pedidosFiltrados = [...this._pedidos];
    } else {
      this.pedidosFiltrados = this._pedidos.filter((a) =>
        [a.codigo, a.codcue, a.nombre, a.unidad, a.inicial, a.actual, a.cosactual].some(
          (campo) =>
            campo !== null && campo !== undefined && String(campo).toLowerCase().includes(filtro)
        )
      );
    }
  }

  ordenarPor(campo: keyof PedidosVisual | 'total'): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.pedidosFiltrados.sort((a: any, b: any) => {
      let valorA: number | string;
      let valorB: number | string;

      if (campo === 'total') {
        valorA = a.actual * a.cosactual;
        valorB = b.actual * b.cosactual;
      } else {
        valorA = a[campo];
        valorB = b[campo];
      }

      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;

      if (typeof valorA === 'string' && typeof valorB === 'string') {
        return this.ordenAscendente ? valorA.localeCompare(valorB) : valorB.localeCompare(valorA);
      }

      return this.ordenAscendente
        ? Number(valorA) - Number(valorB)
        : Number(valorB) - Number(valorA);
    });
  }

  onCellClick(event: any, codcue: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('codcueToInfo', codcue);
      this.router.navigate(['info-cuenta']);
    }
  }
  modificar(idpedido: number) {}
  eliminar(pedido: Pedidos) {}
}
interface PedidosVisual {
  numero: number;
  fecha: Date;
  beneficiario: string;
  destino: string;
  total: number;
}

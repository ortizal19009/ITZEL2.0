import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Pedidos } from '../../../modelos/existencias/pedidos.model';
import { PedidosService } from '../../../servicios/existencias/pedidos.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Destinos } from '../../../modelos/existencias/destinos.model';

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
  ventana: string = 'pedidos';
  totalPages: number = 0;
  constructor(          
    public fb: FormBuilder,
    private router: Router,
    private pediService: PedidosService,
    public authService: AutorizaService,
    private elimService: EliminadosService,
    private coloresService: ColoresService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', `/${this.ventana}`);
    let coloresJSON = sessionStorage.getItem(`/${this.ventana}`);
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    let swbuscar: boolean;
    this.formBuscar = this.fb.group({
      desde: 0,
      hasta: 0,
      beneficiario: '',
      descripcion: '',
      filtroControl: '',
    });
    this.getLastPedido();
    // Escucha cada cambio en el input del filtro
    this.formBuscar.get('filtroControl')?.valueChanges.subscribe((valor?: any) => {
      this.filtrar(valor);
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

  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(
        this.authService.idusuario!,
        `${this.ventana}`
      );
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem(`/${this.ventana}`, coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }
  buscar() {
    const f = this.formBuscar.value;

    // Prioridad de búsqueda (puedes cambiar el orden si quieres)
    if (f.beneficiario && f.beneficiario.trim() !== '') {
      this.buscarPorBeneficiario(f.beneficiario);
    }
    if (f.descripcion && f.descripcion.trim() !== '') {
      this.buscarPorDescripcion(f.descripcion);
    }
    if (f.descripcion == '' && f.beneficiario == '') {
      this.buscarPorNumero(f.desde, f.hasta);
    } /* else {
      this.buscarPageable();
    } */
  }

  buscarPorBeneficiario(beneficiario: string) {
    this.pediService.getPedidosPorBeneficiario(beneficiario).subscribe({
      next: (data: Pedidos[]) => {
        this._pedidos = data;
        this.pedidosFiltrados = data;
        this.calcularTotales();
      },
      error: (err) => {
        console.error('Error al buscar por beneficiario:', err);
      },
    });
  }
  buscarPorDescripcion(descripcion: string) {
    this.pediService.getPedidosPorDescripcion(descripcion).subscribe({
      next: (data: Pedidos[]) => {
        this._pedidos = data;
        this.pedidosFiltrados = data;
        this.calcularTotales();
      },
      error: (err) => {
        console.error('Error al buscar por descripción:', err);
      },
    });
  }
  buscarPorNumero(desde: number, hasta: number) {
    this.pediService.getPedidosPorNumero(desde, hasta).subscribe({
      next: (data: Pedidos[]) => {
        this._pedidos = data;
        this.pedidosFiltrados = data;
        this.calcularTotales();
      },
      error: (err) => {
        console.error('Error al buscar por número:', err);
      },
    });
  }

  buscarPageable(page: number = 0, size: number = 10) {
    this.pediService.getPedidosPaginados(page, size, 'idpedido', 'desc').subscribe({
      next: (data: any) => {
        this._pedidos = data.content;
        this.pedidosFiltrados = data.content;
        this.totalPages = data.totalPages;
        this.calcularTotales();
      },
      error: (err) => {
        console.error('Error al obtener pedidos paginados:', err);
      },
    });
  }
  limpiarDescripcion() {
    this.formBuscar.get('descripcion')?.patchValue('');
  }

  limpiarBeneficiario() {
    this.formBuscar.get('beneficiario')?.patchValue('');
  }

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
      this.pedidosFiltrados = this._pedidos.filter((a: PedidosVisual) =>
        [
          a.numero,
          a.fecha,
          a.nomben,
          a.beneficiario,
          a.destino,
          a.nomdestino,
          a.descripcion,
          a.total,
          a.numdoc,
        ].some(
          (campo) =>
            campo !== null && campo !== undefined && String(campo).toLowerCase().includes(filtro)
        )
      );
    }
  }

  ordenarPor(campo: keyof PedidosVisual | 'numero'): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.pedidosFiltrados.sort((a: any, b: any) => {
      let valorA: number | string;
      let valorB: number | string;

      if (campo === 'numero') {
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

  onCellClick(event: any, idpedido: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('infoToPedido', idpedido);
      this.router.navigate(['info-pedido']);
    }
  }
  modificar(idpedido: number) {
    sessionStorage.setItem('idpedidoToModi', JSON.stringify(idpedido));
    this.router.navigate(['/modi-pedido']);
  }
  eliminar(pedido: Pedidos) {}

  getLastPedido() {
    this.pediService.getLastPedido().subscribe({
      next: (data: number) => {
        if (data > 0) {
          // Restamos 20 pero nos aseguramos de que no sea menor que 0
          let des = Math.max(0, data - 20);
          this.formBuscar.patchValue({
            desde: des,
            hasta: data,
          });
        }
      },
      error: (err) => {
        console.error('Error al obtener el último pedido:', err);
      },
    });
  }
  calcularTotales() {
    this.sumTotal = 0;
    this.pedidosFiltrados.forEach((pedido) => {
      this.sumTotal += pedido.total!;
    });
  }
}
interface PedidosVisual {
  numero: number;
  fecha: Date;
  nomben: string;
  nomdestino: string;
  descripcion: string;
  total: number;
  numdoc: string;
  beneficiario: Beneficiarios;
  destino: Destinos;
}

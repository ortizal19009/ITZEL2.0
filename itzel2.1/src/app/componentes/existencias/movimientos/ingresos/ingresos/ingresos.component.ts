import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { EliminadosService } from '../../../../servicios/administracion/eliminados.service';
import { ColoresService } from '../../../../servicios/administracion/colores.service';
import { MovimientoService } from '../../../../servicios/existencias/movimiento.service';

@Component({
  selector: 'app-ingresos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './ingresos.component.html',
  styleUrl: './ingresos.component.css',
})
export class IngresosComponent implements OnInit {
  formBuscar!: FormGroup;
  txtbuscar: string = 'Buscar';
  swbuscando?: boolean;
  _movimientos: any[] = [];
  movFiltrados: any[] = []
  ventana: string = 'mov-ingresos';
  sumTotal: number = 0;
  ordenColumna: keyof MovimientoVisual = 'numero';
  ordenAscendente: boolean = true;
  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private elimService: EliminadosService,
    private coloresService: ColoresService,
    private movService: MovimientoService
  ) { }
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', `/${this.ventana}`);
    let coloresJSON = sessionStorage.getItem(`/${this.ventana}`);
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();
    this.formBuscar = this.fb.group({
      desde: 0,
      hasta: 0,
      beneficiario: '',
      descripcion: '',
      filtroControl: '',
    });
  }
  nuevo() {
    this.router.navigate(['/add-mov-ingreso']);
  }
  imprimir() { }
  buscar() {
    this.swbuscando = true;
    this.txtbuscar = 'Buscando...';
    this.movService.getAllMovimientos().subscribe({
      next: (data) => {
        console.log(data);
        this._movimientos = data;
        this.movFiltrados = data;
        this.swbuscando = false;
        this.txtbuscar = 'Buscar';
      },
      error: (e) => {
        console.error(e);
        this.swbuscando = false;
        this.txtbuscar = 'Buscar';
      }
    });

  }
  cerrar() {
    this.router.navigate(['/inicio']);
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }
  modificar(id: number) { }
  eliminar(id: number) { }
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

  ordenarPor(campo: keyof MovimientoVisual | 'numero'): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.movFiltrados.sort((a: any, b: any) => {
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
      sessionStorage.setItem('infoToIngMovimientos', idpedido);
      this.router.navigate(['info-ing-movimientos']);
    }
  }
}
interface MovimientoVisual {
  numero: number;
  fecha: string;
  beneficiario: string;
  descripcion: string;
  actual: number;
  cosactual: number;
  nomben: string;
  total: number;
  numdoc: string;
  nomdestino: string;
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { EjecucionService } from '../../../servicios/contabilidad/ejecucion.service';
import { ArticulosService } from '../../../servicios/existencias/articulos.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import Swal from 'sweetalert2';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';

@Component({
  selector: 'app-articulos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './articulos.component.html',
  styleUrl: './articulos.component.css',
})
export class ArticulosComponent implements OnInit {
  formBuscar: any;
  swbuscando?: boolean;
  txtbuscar: string = 'Buscar';
  buscarArticulos = { codigo: String, codcue: String, nombre: String };
  _articulos: Articulos[] = [];
  artiFiltrados: Articulos[] = [];
  sumTotal = 0;
  _cuentas: any;
  iArticulo = {} as interfaceArticulo; //Interface para los datos del Artículo a eliminar
  sweliminar: boolean = false;

  ordenColumna: keyof ArticuloVisual = 'codigo';
  ordenAscendente: boolean = true;

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private elimService: EliminadosService,
    private coloresService: ColoresService,
    private artiService: ArticulosService,
    private ejecuService: EjecucionService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/arsticulos');
    let coloresJSON = sessionStorage.getItem('/articulos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    let swbuscar: boolean;
    //Campos guardados o ''
    let codigo: string;
    let codcue: string;
    let nombre: string;
    const buscarArticulosJSON = sessionStorage.getItem('buscarArticulos');
    if (buscarArticulosJSON) {
      swbuscar = true;
      const buscaArticulos = JSON.parse(buscarArticulosJSON);
      codigo = buscaArticulos.codigo;
      codcue = buscaArticulos.codcue;
      nombre = buscaArticulos.nombre;
    } else {
      swbuscar = false;
      codigo = '';
      codcue = '';
      nombre = '';
    }

    this.formBuscar = this.fb.group({
      codigo: codigo,
      codcue: codcue,
      nombre: nombre,
      filtroControl: '',
    });
    // Escucha cada cambio en el input del filtro
    this.formBuscar.get('filtroControl')?.valueChanges.subscribe((total: any) => {
      this.filtrar(total);
    });

    if (swbuscar) this.buscar();
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
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'articulos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/articulos', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }

  buscar(): void {
    this.swbuscando = true;
    let codigo = this.formBuscar.value.codigo;
    let codcue = this.formBuscar.value.codcue;
    let nombre = this.formBuscar.value.nombre;
    this.artiService.getByCodigoyCodueyNombre(codigo, codcue, nombre).subscribe({
      next: (articulos: Articulos[]) => {
        this._articulos = articulos;
        this.artiFiltrados = [...articulos];
        this.artiFiltrados = articulos.map((a) => ({
          ...a,
          total: Math.round((a.actual ?? 0) * (a.cosactual ?? 0) * 10000) / 10000,
        }));
        //Guarda los campos de búsqueda
        this.buscarArticulos = {
          codigo: this.formBuscar.value.codigo,
          codcue: this.formBuscar.value.codcue,
          nombre: this.formBuscar.value.nombre,
        };

        // Verifica si hay al menos un campo con valor
        const tieneFiltro = Object.values(this.buscarArticulos).some(
          (valor) => valor !== null && valor !== undefined && valor.toString().trim() !== ''
        );
        if (tieneFiltro) {
          sessionStorage.setItem('buscarArticulos', JSON.stringify(this.buscarArticulos));
        } else {
          sessionStorage.removeItem('buscarArticulos');
        }
        this.sumCostotal();
        this.swbuscando = false;
        this.swbuscando = false;
        this.txtbuscar = 'Buscar';
      },
      error: (err) => {
        console.error('Al buscar artículos:', err);
      },
    });
  }

  filtrar(valor: any): void {
    const filtro = String(valor).toLowerCase();
    if (!filtro) {
      this.artiFiltrados = [...this._articulos];
    } else {
      this.artiFiltrados = this._articulos.filter((a) =>
        [a.codigo, a.codcue, a.nombre, a.unidad, a.inicial, a.actual, a.cosactual].some(
          (campo) =>
            campo !== null && campo !== undefined && String(campo).toLowerCase().includes(filtro)
        )
      );
    }
    this.sumCostotal();
  }

  ordenarPor(campo: keyof ArticuloVisual | 'total'): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.artiFiltrados.sort((a, b) => {
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

  sumCostotal(): number {
    this.sumTotal =
      this.artiFiltrados?.reduce((total, articulo) => {
        const cantidad = articulo.actual ?? 0;
        const costoUnitario = articulo.cosactual ?? 0;
        return total + cantidad * costoUnitario;
      }, 0) || 0;
    return this.sumTotal;
  }

  onCellClick(event: any, codcue: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('codcueToInfo', codcue);
      this.router.navigate(['info-cuenta']);
    }
  }

  nuevo() {
    this.router.navigate(['/add-articulo']);
  }

  modificar(idarticulo: number) {
    sessionStorage.setItem('idarticuloToModi', JSON.stringify(idarticulo));
    this.router.navigate(['/modi-articulo']);
  }

  eliminar(articulo: Articulos): void {
    this.ejecuService.countEjecucionPorPartida(articulo.idarticulo).subscribe({
      next: (registros: any) => {
        if (registros > 0) {
          Swal.fire({
            icon: 'error',
            title: `No puede eliminar el Artículo: ${articulo.codigo}`,
            text: `Tiene registrado ${registros} movimientos`,
            confirmButtonText: '<i class="bi-check"></i> Continuar ',
            customClass: {
              popup: 'noeliminar',
              title: 'robotobig',
              confirmButton: 'btn btn-warning',
            },
          });
        } else {
          Swal.fire({
            width: '500px',
            title: 'Mensaje',
            // text: `Eliminar el Artículo: ${articulo.codigo}<br>${articulo.nombre}`,
            html: `Eliminar el Artículo: <b>${articulo.codigo}</b><br>${articulo.nombre}`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '<i class="fa fa-check"></i> Aceptar',
            cancelButtonText: '<i class="fa fa-times"></i> Cancelar',
            customClass: {
              popup: 'eliminar',
              title: 'robotobig',
              confirmButton: 'btn btn-success',
              cancelButton: 'btn btn-success',
            },
          }).then((resultado) => {
            if (resultado.isConfirmed) this.elimina(articulo);
          });
        }
      },
      error: (err) => {
        console.error('Al buscar si la Partida de Gastos tiene registros: ', err.error);
        this.authService.mostrarError('Error al buscar si tiene registros', err.error);
      },
    });
  }

  //Elimina
  elimina(articulo: Articulos) {
    this.artiService.deleteArticulo(articulo.idarticulo).subscribe({
      next: () => {
        this.buscar();
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'articulos';
        eliminado.tabla = 'ARTICULOS';
        eliminado.datos = `${articulo.codigo} ${articulo.nombre}`;
        this.elimService.save(eliminado).subscribe({
          next: () => {
            Swal.fire('Mensaje', 'La acción fue ejecutada.', 'success');
            this.buscar();
          },
          error: (err) => {
            console.error(err.error);
            this.authService.mostrarError('Error al eliminar', err.error);
          },
        });
      },
      error: (err) => {
        console.error(err.error);
        this.authService.mostrarError('Error al eliminar', err.error);
      },
    });
  }

  imprimir() {}

  cerrar() {
    this.router.navigate(['/inicio']);
  }
}

interface interfaceArticulo {
  idarticulo: number;
  codigo: string;
  nombre: string;
}

interface ArticuloVisual {
  codigo: string;
  codcue: string;
  nombre: string;
  unidad: string;
  inicial: number;
  actual: number;
  cosactual: number;
  total: number;
}

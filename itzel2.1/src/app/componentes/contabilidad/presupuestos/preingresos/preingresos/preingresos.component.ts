import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Presupuesto } from '../../../../modelos/contabilidad/presupuesto.model';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../../servicios/administracion/colores.service';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import { EliminadosService } from '../../../../servicios/administracion/eliminados.service';
import Swal from 'sweetalert2';
import { Eliminados } from '../../../../modelos/administracion/eliminados.model';
import { EjecucionService } from '../../../../servicios/contabilidad/ejecucion.service';

@Component({
  selector: 'app-preingresos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './preingresos.component.html',
  styleUrl: './preingresos.component.css',
})
export class PreingresosComponent implements OnInit {
  formBuscar: any;
  swbuscando?: boolean;
  txtbuscar: string = 'Buscar';
  buscarPreingresos = { codpar: String, nompar: String };
  _preingresos: any[] = [];
  suminicial = 0;
  sumreforma = 0;
  sumcodificado = 0;
  iPartida = {} as interfacePreingresos; //Interface para los datos de la Partida de Ingresos a eliminar
  sweliminar: boolean = false;
  partiFiltradas: Presupuesto[] = [];
  ordenColumna: keyof PreingresosVisual = 'codpar';
  ordenAscendente: boolean = true;

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private ejecuService: EjecucionService,
    private presuService: PresupuestoService,
    private elimService: EliminadosService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/preingresos');
    let coloresJSON = sessionStorage.getItem('/preingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    let swbuscar: boolean;
    //Campos guardados o ''
    let codpar: string;
    let nompar: string;
    const buscarPreingresosJSON = sessionStorage.getItem('buscarPreingresos');
    if (buscarPreingresosJSON) {
      swbuscar = true;
      const buscaPartidas = JSON.parse(buscarPreingresosJSON);
      codpar = buscaPartidas.codpar;
      nompar = buscaPartidas.nompar;
    } else {
      swbuscar = false;
      codpar = '';
      nompar = '';
    }
    this.formBuscar = this.fb.group({
      codpar: codpar,
      nompar: nompar,
      filtroControl: '',
    });
    // Escucha cada cambio en el input del filtro
    this.formBuscar.get('filtroControl')?.valueChanges.subscribe((valor: any) => {
      this.filtrar(valor);
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
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'preingresos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/preingresos', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }

  buscar(): void {
    this.swbuscando = true;
    this.formBuscar.get('filtroControl')?.setValue(''); // Limpia el filtro
    let codpar = this.formBuscar.value.codpar;
    let nompar = this.formBuscar.value.nompar;
    this.presuService.getByCodparyNompar(1, codpar, nompar).subscribe({
      next: (datos) => {
        this._preingresos = datos;
        this.partiFiltradas = [...datos];
        //Guarda los campos de búsqueda
        this.buscarPreingresos = {
          codpar: this.formBuscar.value.codpar,
          nompar: this.formBuscar.value.nompar,
        };
        // Verifica si hay al menos un campo con valor
        const camposBusca = Object.values(this.buscarPreingresos).some(
          (valor) => valor !== null && valor !== undefined && valor.toString().trim() !== ''
        );
        if (camposBusca)
          sessionStorage.setItem('buscarPreingresos', JSON.stringify(this.buscarPreingresos));
        else sessionStorage.removeItem('buscarPreingresos');

        this.calcTotales();
        this.swbuscando = false;
        this.swbuscando = false;
        this.txtbuscar = 'Buscar';
      },
      error: (err) => console.error('❌ Error al buscar las Partidas de Ingresos:', err.error),
    });
  }

  calcTotales(): void {
    this.suminicial = 0;
    this.sumreforma = 0;
    for (const partida of this.partiFiltradas) {
      this.suminicial += partida.inicial || 0;
      this.sumreforma += partida.totmod || 0;
    }
    this.sumcodificado = this.suminicial + this.sumreforma;
  }

  filtrar(valor: any): void {
    const filtro = valor.toLowerCase();
    if (!filtro) {
      if (this.partiFiltradas.length > 0) this.partiFiltradas = [...this._preingresos];
      this.calcTotales();
      return;
    }
    this.partiFiltradas = this._preingresos.filter((a) => {
      const codificado = (a.inicial || 0) + (a.totmod || 0);
      return [a.codpar, a.nompar, a.inicial, a.totmod, codificado].some((campo) =>
        String(campo).toLowerCase().includes(filtro)
      );
    });
    this.calcTotales();
  }

  ordenarPor(campo: keyof PreingresosVisual | 'codificado'): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo as keyof PreingresosVisual;
      this.ordenAscendente = true;
    }
    this.partiFiltradas.sort((a, b) => {
      let valorA: any;
      let valorB: any;
      if (campo === 'codificado') {
        valorA = (a as any)['inicial'] + (a as any)['totmod'];
        valorB = (b as any)['inicial'] + (b as any)['totmod'];
      } else {
        valorA = (a as any)[campo];
        valorB = (b as any)[campo];
      }
      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;
      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';
      return esNumero
        ? this.ordenAscendente
          ? valorA - valorB
          : valorB - valorA
        : this.ordenAscendente
        ? String(valorA).localeCompare(String(valorB))
        : String(valorB).localeCompare(String(valorA));
    });
  }

  onCellClick(event: any, codcue: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('preingresosToInfo', codcue);
      this.router.navigate(['info-preingresos']);
    }
  }

  nuevo() {
    this.router.navigate(['/add-partidaing']);
  }

  modificar(idpresupuesto: number) {
    sessionStorage.setItem('idpresupuestoToModi', JSON.stringify(idpresupuesto));
    this.router.navigate(['/modi-partidaing']);
  }

  //Datos a eliminar
  /*   eliminar(partida: Presupuesto): void {
    this.ejecuService.countEjecucionPorPartida(partida.idpresupuesto).subscribe({
      next: (registros: any) => {
        if (registros > 0) {
          Swal.fire({
            icon: 'error',
            title: 'No puede eliminar la Partida de Ingresos: ' + partida.nompar,
            text: 'Tiene registrado ' + registros + ' movimientos',
            confirmButtonText: '<i class="bi-check"></i> Continuar ',
            customClass: {
              popup: 'noeliminar',
              title: 'robotobig',
              confirmButton: 'btn btn-info',
            },
          });
        } else {
          Swal.fire({
            width: '500px',
            title: 'Mensaje',
            text:
              'Eliminar la Partida de Ingresos:\n ' + partida.codpar + ' ' + partida.nompar + ' ?',
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
            if (resultado.isConfirmed) this.elimina(partida);
          });
        }
      },
      error: (err: any) =>
        console.error('Al buscar si la Partida de Ingresos tiene registros: ', err.error),
    });
  } */

  //Elimina
  elimina(partida: Presupuesto) {
    this.presuService.delete(partida.idpresupuesto).subscribe({
      next: () => {
        this.buscar();
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'preingresos';
        eliminado.tabla = 'PRESUPUESTO';
        eliminado.datos = `${partida.codpar} ${partida.nompar}`;
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

interface interfacePreingresos {
  idclasificador: number;
  codpar: string;
  nompar: string;
}

interface PreingresosVisual {
  codpar: string;
  nompar: string;
  inicial: number;
  totmod: number;
  codificado: number;
}

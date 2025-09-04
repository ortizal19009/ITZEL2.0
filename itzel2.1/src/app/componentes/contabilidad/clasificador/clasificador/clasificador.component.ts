import { Component, OnInit } from '@angular/core';
import { Clasificador } from '../../../modelos/contabilidad/clasificador.model';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ClasificadorService } from '../../../servicios/contabilidad/clasificador.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { PresupuestoService } from '../../../servicios/contabilidad/presupuesto.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import Swal from 'sweetalert2';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-clasificador.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './clasificador.component.html',
  styleUrl: './clasificador.component.css'
})
export class ClasificadorComponent implements OnInit {

  formBuscar: any;
  swbuscando?: boolean;
  txtbuscar: string = 'Buscar';
  buscarClasificador = { codpar: String, nompar: String }
  _clasificador: any[] = [];
  sumTotal = 0;
  iPartida = {} as interfaceClasificador; //Interface para los datos de la Partida del clasificador a eliminar
  sweliminar: boolean = false;
  partiFiltradas: Clasificador[] = [];
  ordenColumna: keyof ClasificadorVisual = 'codpar';
  ordenAscendente: boolean = true;

  constructor(public fb: FormBuilder, private router: Router, public authService: AutorizaService,
    private coloresService: ColoresService, private clasiService: ClasificadorService,
    private presuService: PresupuestoService, private elimService: EliminadosService) { }

  ngOnInit(): void {
    if (!this.authService.sessionlog) { this.router.navigate(['/inicio']); }
    sessionStorage.setItem('ventana', '/clasificador');
    let coloresJSON = sessionStorage.getItem('/clasificador');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    let swbuscar: boolean;
    //Campos guardados o ''
    let codpar: string; let nompar: string;
    const buscarClasificadorJSON = sessionStorage.getItem('buscarClasificador');
    if (buscarClasificadorJSON) {
      swbuscar = true;
      const buscaClasificador = JSON.parse(buscarClasificadorJSON);
      codpar = buscaClasificador.codpar;
      nompar = buscaClasificador.nompar;
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
    this.formBuscar.get('filtroControl')?.valueChanges.subscribe((valor: any) => { this.filtrar(valor) });

    if (swbuscar) this.buscar();

  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1')
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'clasificador');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/clasificador', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }

  buscar(): void {
    this.swbuscando = true;
    this.formBuscar.get('filtroControl')?.setValue('');   // Limpia el filtro
    let codpar = this.formBuscar.value.codpar;
    let nompar = this.formBuscar.value.nompar;
    this.clasiService.getByCodparyNompar(codpar, nompar)
      .subscribe({
        next: datos => {
          this._clasificador = datos;
          this.partiFiltradas = [...datos]; // 👈 inicializa con todos
          //Guarda los campos de búsqueda
          this.buscarClasificador = {
            codpar: this.formBuscar.value.codpar,
            nompar: this.formBuscar.value.nompar
          };
          // Verifica si hay al menos un campo con valor
          const camposBusca = Object.values(this.buscarClasificador)
            .some(valor => valor !== null && valor !== undefined && valor.toString().trim() !== '');
          if (camposBusca) sessionStorage.setItem('buscarClasificador', JSON.stringify(this.buscarClasificador));
          else sessionStorage.removeItem('buscarClasificador');

          this.swbuscando = false;
          this.swbuscando = false;
          this.txtbuscar = 'Buscar';
        },
        error: err => console.error('❌ Error al buscar las Partidas del Clasificador:', err.error)
      });
  }

  filtrar(valor: any): void {
    const filtro = valor.toLowerCase();
    if (!filtro) {
      if (this.partiFiltradas.length > 0) { this.partiFiltradas = [...this._clasificador] }
      return
    };
    this.partiFiltradas = this._clasificador.filter(a =>
      [a.codpar, a.nompar, a.despar].some(
        campo => campo?.toLowerCase().includes(filtro)
      )
    );
  }

  ordenarPor(campo: keyof ClasificadorVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }
    this.partiFiltradas.sort((a, b) => {
      const valorA = a[campo];
      const valorB = b[campo];
      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;
      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';
      return esNumero
        ? (this.ordenAscendente ? valorA - valorB : valorB - valorA)
        : this.ordenAscendente
          ? String(valorA).localeCompare(String(valorB))
          : String(valorB).localeCompare(String(valorA));
    });
  }

  onCellClick(event: any, codpar: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('clasificadorToInfo', codpar);
      this.router.navigate(['info-clasificador']);
    }
  }

  nuevo() { this.router.navigate(['/add-clasificador']); }

  modificar(idclasificador: number) {
    sessionStorage.setItem('idclasificadorToModi', JSON.stringify(idclasificador));
    this.router.navigate(['/modi-clasificador']);
  }

  //Datos a eliminar
  eliminar(partida: Clasificador): void {
    this.presuService.countPresupuestoPorClasificador(partida.idclasificador).subscribe({
      next: (registros: any) => {
        if (registros > 0) {
          Swal.fire({
            icon: 'error',
            title: 'No puede eliminar la Partida del Clasificador: ' + partida.nompar,
            text: 'Tiene registrado ' + registros + ' Partidas presupuestarias',
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
            text: 'Eliminar la Partida del Clasificador:\n ' + partida.nompar + ' ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '<i class="fa fa-check"></i> Aceptar',
            cancelButtonText: '<i class="fa fa-times"></i> Cancelar',
            customClass: {
              popup: 'eliminar',
              title: 'robotobig',
              confirmButton: 'btn btn-success',
              cancelButton: 'btn btn-success'
            },
          }).then((resultado) => {
            if (resultado.isConfirmed) this.elimina(partida);
          });
        }
      },
      error: (err: any) => console.error('Al buscar si la Partida del Clasificador tiene registros: ', err.error),
    });
  }

  //Elimina
  elimina(partida: Clasificador) {
    this.clasiService.delete(partida.idclasificador).subscribe({
      next: () => {
        this.buscar();
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'clasificador';
        eliminado.tabla = 'CLASIFICADOR';
        eliminado.datos = `${partida.codpar} ${partida.nompar}`;
        this.elimService.save(eliminado).subscribe({
          next: () => {
            Swal.fire('Mensaje', 'La acción fue ejecutada.', 'success');
            this.buscar();
          },
          error: err => {
            console.error(err.error);
            this.authService.mostrarError('Error al eliminar', err.error);
          }
        });
      },
      error: err => {
        console.error(err.error);
        this.authService.mostrarError('Error al eliminar', err.error);
      }
    });
  }

  imprimir() {

  }

  cerrar() { this.router.navigate(['/inicio']); }

}


interface interfaceClasificador {
  idclasificador: number;
  codpar: string;
  nompar: string;
}

interface ClasificadorVisual {
  codpar: string;
  nompar: string;
  despar: string;
}
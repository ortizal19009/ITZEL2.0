import { Component, OnInit } from '@angular/core';
import { Reportesjr } from '../../../modelos/administracion/reportesjr.model';
import { FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { EjecucionService } from '../../../servicios/contabilidad/ejecucion.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { ReportesjrService } from '../../../servicios/administracion/reportesjr.service';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';
import { RepoxopcionService } from '../../../servicios/administracion/repoxopcion.service';

@Component({
  selector: 'app-reportesjr.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './reportesjr.component.html',
  styleUrl: './reportesjr.component.css',
})
export class ReportesjrComponent implements OnInit {
  formBuscar: any;
  swbuscando?: boolean;
  txtbuscar: string = 'Buscar';
  buscarReportesjr = { codigo: String, nomrep: String, desrep: String }; //codigo es repoxopcion.codigo
  _repoxopcion: any[] = [];
  _reportesjr: any[] = [];
  suminicial = 0;
  sumreforma = 0;
  sumcodificado = 0;
  // iRepojr = {} as interfaceReportesjr; //Interface para los datos del Reportejr a eliminar
  sweliminar: boolean = false;
  repojrFiltrados: Reportesjr[] = [];
  ordenColumna: keyof ReportesjrVisual = 'codigo';
  ordenAscendente: boolean = true;
  totalParametros: number[] = [];

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private ejecuService: EjecucionService,
    private repoxopService: RepoxopcionService,
    private repojrService: ReportesjrService,
    private elimService: EliminadosService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/reportesjr');
    let coloresJSON = sessionStorage.getItem('/reportesjr');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    let swbuscar: boolean;
    //Campos guardados o ''
    let codigo: string;
    let nomrep: string;
    let desrep: string;
    const buscarPregastosJSON = sessionStorage.getItem('buscarReportesjr');
    // console.log('buscarPregastosJSON:', buscarPregastosJSON);
    if (buscarPregastosJSON) {
      swbuscar = true;
      const buscaPartidas = JSON.parse(buscarPregastosJSON);
      codigo = buscaPartidas.codigo;
      nomrep = buscaPartidas.nomrep;
      desrep = buscaPartidas.desrep;
    } else {
      swbuscar = false;
      codigo = '';
      nomrep = '';
      desrep = '';
    }

    this.formBuscar = this.fb.group({
      repoxopcion: '',
      nomrep: nomrep,
      desrep: desrep,
      filtroControl: '',
    });

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
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'reportesjr');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/reportesjr', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }

  //Datalist de las opciones (repoxopcion)
  repoxopcion(e: any) {
    if (e.target.value != '') {
      this.repoxopService.obtenerPorCodigo(e.target.value).subscribe({
        next: (datos) => (this._repoxopcion = datos),
        error: (err) => {
          console.error(err.error);
          this.authService.mostrarError('Error al buscar Repoxopcion', err.error);
        },
      });
    }
  }

  buscar(): void {
    this.swbuscando = true;
    this.txtbuscar = 'Buscando';
    this.formBuscar.get('filtroControl')?.setValue('');
    let codigo = this.formBuscar.value.repoxopcion;
    let nomrep = this.formBuscar.value.nomrep;
    let desrep = this.formBuscar.value.desrep;
    // console.log('Busca: ', codigo, codpar, nompar);
    this.repojrService.getByOpcionNomrepyDesrep(codigo, nomrep, desrep).subscribe({
      next: (datos) => {
        this._reportesjr = datos;
        this.calcCantidadPorRegistro();
        this.repojrFiltrados = [...datos];
        //Guarda los campos de búsqueda
        this.buscarReportesjr = {
          codigo: this.formBuscar.value.repoxopcion,
          nomrep: this.formBuscar.value.nomrep,
          desrep: this.formBuscar.value.desrep,
        };
        // Verifica si hay al menos un campo con valor para guardar en session
        const camposBusca = Object.values(this.buscarReportesjr).some(
          (valor) => valor !== null && valor !== undefined && valor.toString().trim() !== ''
        );
        if (camposBusca)
          sessionStorage.setItem('buscarReportesjr', JSON.stringify(this.buscarReportesjr));
        else sessionStorage.removeItem('buscarReportesjr');
        this.swbuscando = false;
        this.txtbuscar = 'Buscar';
      },
      error: (err) => {
        console.error('❌ Error al buscar las Opciones:', err.error);
        this.authService.mostrarError('Error al buscar las Opciones', err.error);
      },
    });
  }

  calcCantidadPorRegistro(): void {
    this.totalParametros = []; // reiniciar el arreglo

    for (const r of this._reportesjr) {
      try {
        const safeParametros = JSON.parse(r.parametros || '{}');

        const cantidad = Object.entries(safeParametros).filter(([_, valor]) => {
          const partes = String(valor).split('|');
          return partes.length === 2 && partes[0].includes('.') && partes[1].trim() !== '';
        }).length;

        this.totalParametros.push(cantidad);
      } catch {
        this.totalParametros.push(0); // si el JSON está mal, se guarda 0
      }
    }
  }

  filtrar(valor: any): void {
    const filtro = valor.toLowerCase();
    if (!filtro) {
      if (this.repojrFiltrados.length > 0) this.repojrFiltrados = [...this._reportesjr];
      return;
    }
    this.repojrFiltrados = this._reportesjr.filter((a) => {
      return [a.codigo, a.nomrep, a.desrep].some((campo) =>
        String(campo).toLowerCase().includes(filtro)
      );
    });
  }

  ordenarPor(campo: keyof ReportesjrVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.repojrFiltrados.sort((a: any, b: any) => {
      let valorA: any;
      let valorB: any;
      switch (campo) {
        case 'codigo':
          valorA = `${a.repoxopcion.codigo}`;
          valorB = `${b.repoxopcion.codigo}`;
          break;
        case 'opcion':
          valorA = a.repoxopcion.opcion;
          valorB = b.repoxopcion.opcion;
          break;
        default:
          valorA = a[campo];
          valorB = b[campo];
          break;
      }
      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;

      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';

      if (esNumero) {
        return this.ordenAscendente ? valorA - valorB : valorB - valorA;
      } else {
        return this.ordenAscendente
          ? String(valorA).localeCompare(String(valorB))
          : String(valorB).localeCompare(String(valorA));
      }
    });
  }

  onCellClick(event: any, repo: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('reportejrToImpExp', repo.idreporte.toString());
      this.router.navigate(['imp-reportejr']);
    }
  }

  nuevo() {
    this.router.navigate(['/add-reportejr']);
  }

  parametros(repo: Reportesjr) {
    let parametros = repo.parametros;

    // Asegura que parametros sea un objeto antes de usar Object.entries
    const safeParametros = parametros && typeof parametros === 'object' ? parametros : {};

    // Construir filas de la tabla
    const filas = Object.entries(safeParametros)
      .map(([nombre, valor]) => {
        const [tipoCompleto, longitud] = String(valor).split('|');
        const tipoSimple = tipoCompleto.split('.').pop();
        return `<tr><td><strong>${nombre}</strong></td><td>${tipoSimple}</td><td>${longitud}</td></tr>`;
      })
      .join('');

    // Mostrar el modal con tabla
    Swal.fire({
      title: `Parámetros del Reporte: ${repo.nomrep}`,
      // html: `<table style="width:100%; text-align:left; border-collapse:collapse">
      html: `<table class="table table-hover table-bordered table-sm sombra mb-0">
         <thead class="bg-success text-white">
         <tr><th>Parametro</th><th>Tipo</th><th>Longitud</th></tr>
         </thead>
         <tbody class="roboto">
            ${filas}
         </tbody>
         </table> `,
      // icon: 'info',
      confirmButtonText: 'Cerrar',
      customClass: {
        confirmButton: 'btn btn-success',
        popup: 'swaInfo',
        title: 'swafantacyblack',
      },
    });
  }

  modificar(idreporte: number) {
    sessionStorage.setItem('idreporteToModi', idreporte.toString());
    this.router.navigate(['/modi-reportejr']);
  }

  //Datos a eliminar
  eliminar(repo: Reportesjr): void {
    this.ejecuService.countEjecucionPorPartida(repo.idreporte!).subscribe({
      next: (registros: any) => {
        if (registros > 0) {
          Swal.fire({
            icon: 'error',
            title:
              'No puede eliminar el Reporte:\n ' + repo.repoxopcion!.codigo + ' ' + repo.nomrep,
            text: 'Tiene registrado ' + registros + ' movimientos',
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
            text: 'Eliminar el Reporte:\n ' + repo.repoxopcion!.codigo + ' ' + repo.nomrep + ' ?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '<i class="fa fa-check"></i> Aceptar',
            cancelButtonText: '<i class="fa fa-times"></i> Cancelar',
            customClass: {
              popup: 'eliminar',
              title: 'robotobig',
              confirmButton: 'btn btn-info',
              cancelButton: 'btn btn-info',
            },
          }).then((resultado) => {
            if (resultado.isConfirmed) this.elimina(repo);
          });
        }
      },
      error: (err) => {
        console.error('Al buscar si el Reporte tiene registros: ', err.error);
        this.authService.mostrarError('Error al buscar si tiene registros', err.error);
      },
    });
  }

  //Elimina
  elimina(repo: Reportesjr) {
    this.repojrService.delete(repo.idreporte!).subscribe({
      next: () => {
        this.buscar();
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'reportesjr';
        eliminado.tabla = 'REPORTESJR';
        eliminado.datos = `${repo.repoxopcion!.codigo} ${repo.nomrep}`;
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

interface ReportesjrVisual {
  codigo: string;
  opcion: string;
  nomrep: string;
  desrep: string;
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { TransaccionesService } from '../../../servicios/contabilidad/transacciones.service';
import { Proyectos } from '../../../modelos/contabilidad/proyectos.model';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';

@Component({
  selector: 'app-asientos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './asientos.component.html',
  styleUrl: './asientos.component.css',
})
export class AsientosComponent implements OnInit {
  formBuscar!: FormGroup;
  _proyectos: any[] = [];
  _asientos: any[] = [];
  swbuscando!: boolean;
  txtbuscar: string = 'Buscar';
  buscarAsientos!: {
    tipcom: number;
    desdeNum: number;
    hastaNum: number;
    desdeFecha: string;
    hastaFecha: string;
  };
  swdesdehasta!: boolean; //Visibilidad Buscar últimos
  asieFiltrados: any[] = [];
  ordenColumna: keyof AsientosVisual = 'numero';
  ordenAscendente: boolean = true;

  comprobantes = [
    { tipcom: 0, icono: 'bi-calendar3-range-fill', nombre: 'Asientos' },
    { tipcom: 1, icono: 'bi-arrow-down-right-circle', nombre: 'Ingresos' },
    { tipcom: 2, icono: 'bi-arrow-up-left-circle', nombre: 'Egresos' },
    { tipcom: 3, icono: 'bi-calendar-day', nombre: 'Diarios C' },
    { tipcom: 4, icono: 'bi-arrow-down-right-square', nombre: 'Diarios I' },
    { tipcom: 5, icono: 'bi-arrow-down-left-square', nombre: 'Diarios E' },
  ];

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private asiService: AsientosService,
    private proyService: ProyectosService,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private tranService: TransaccionesService
  ) {}

  ngOnInit(): void {
    sessionStorage.setItem('ventana', '/asientos');
    let coloresJSON = sessionStorage.getItem('/asientos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    const datos = this.authService.getDatosEmpresa();
    const año = datos!.fechap.toString().slice(0, 4);
    this.formBuscar = this.fb.group({
      proyecto: [''],
      nombreProyecto: [''],
      nombrecompro: 'Asientos',
      tipcom: '',
      desdeNum: '',
      hastaNum: '',
      desdeFecha: año + '-01-01',
      hastaFecha: año + '-12-31',
      filtroControl: '',
    });

    //Datos de búsqueda último asiento o guardados
    this.buscarAsientos = JSON.parse(sessionStorage.getItem('buscarAsientos')!);
    if (this.buscarAsientos == null) this.ultimoAsiento();
    else {
      this.formBuscar.patchValue({
        tipcom: this.buscarAsientos.tipcom,
        desdeNum: this.buscarAsientos.desdeNum,
        hastaNum: this.buscarAsientos.hastaNum,
        desdeFecha: this.buscarAsientos.desdeFecha,
        hastaFecha: this.buscarAsientos.hastaFecha,
      });
      this.buscar();
    }
    this.formBuscar.get('filtroControl')?.valueChanges.subscribe((valor: any) => {
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
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'asientos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/asientos', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }

  //Datalist de los Proyectos
  proyectoxCodigo(e: any) {
    if (e.target.value != '') {
      this.proyService.proyectosPorCodigo(e.target.value).subscribe({
        next: (proyectos: Proyectos[]) => {
          this._proyectos = proyectos;
        },
        error: (err) => {
          console.error(err.error);
          this.authService.mostrarError('Error al buscar Proyectos', err.error);
        },
      });
    }
  }
  onProyectoSelected(e: any) {
    const selectedOption = this._proyectos.find(
      (x: { codigo: any }) => x.codigo === e.target.value
    );
    // console.log('e:',e, 'e.target.value: ', e.target.value, 'selectedOption: ', selectedOption);

    if (selectedOption) {
      this.formBuscar.controls['nombreProyecto'].setValue(selectedOption.nombre);
      // this.idproyecto = selectedOption.idproyecto;
    } else {
      this.formBuscar.controls['nombreProyecto'].setValue('');
      // this.idproyecto = null;
    }
  }

  changeComprobante(comp: any) {
    this.formBuscar.controls['nombrecompro'].setValue(comp.nombre);
    this.formBuscar.controls['tipcom'].setValue(comp.tipcom);
    // let ultimoCompro: number;
    // this.tipcom = comp.tipcom;
    // this.asiService.obtenerUltimoCompro(this.tipcom).subscribe({
    //    next: resp => {
    //       ultimoCompro = resp;
    //       this.formAsiento.patchValue({ compro: ultimoCompro + 1 })
    //    },
    //    error: err => { console.error(err.error); this.authService.mostrarError('Error Último Comprobante', err.error) }
    // });
  }

  //Busca el último asiento (todo el registro) y coloca los valores en el formulario
  ultimoAsiento() {
    this.asiService.ultimo().subscribe({
      next: (ultimoNumero) => {
        let desde = ultimoNumero - 16;
        if (desde <= 0) desde = 1;
        this.formBuscar.patchValue({
          tipcom: 0,
          desdeNum: desde,
          hastaNum: ultimoNumero,
        });
        this.buscar();
      },
      error: (err) => {
        console.error(err.error);
        this.authService.mostrarError('Error al buscar ultimo', err.error);
      },
    });
  }

  changeTipcom() {
    if (this.formBuscar.value.tipcom == 0) this.ultimoAsiento();
    else {
      this.asiService.obtenerUltimoCompro(this.formBuscar.value.tipcom).subscribe({
        next: (resp) => {
          let desde = resp - 16;
          if (desde <= 0) desde = 1;
          this.formBuscar.patchValue({
            desdeNum: desde,
            hastaNum: resp,
          });
          this.buscar();
        },
        error: (err) => console.error(err.error),
      });
    }
  }

  buscar() {
    this.swbuscando = true;
    this.txtbuscar = 'Buscando';
    //Guarda los datos de búsqueda
    this.buscarAsientos = {
      tipcom: this.formBuscar.value.tipcom,
      desdeNum: this.formBuscar.value.desdeNum,
      hastaNum: this.formBuscar.value.hastaNum,
      desdeFecha: this.formBuscar.value.desdeFecha,
      hastaFecha: this.formBuscar.value.hastaFecha,
    };
    sessionStorage.setItem('buscarAsientos', JSON.stringify(this.buscarAsientos));

    //Numeros
    let desdeNum: number = 1;
    if (this.formBuscar.value.desdeNum != null) {
      desdeNum = this.formBuscar.value.desdeNum;
    }
    let hastaNum: number = 999999999;
    if (this.formBuscar.value.hastaNum != null) {
      hastaNum = this.formBuscar.value.hastaNum;
    }
    //Busca Asientos
    if (this.formBuscar.value.tipcom == 0)
      this.asiService
        .buscaByNumeroYFecha(
          desdeNum,
          hastaNum,
          this.formBuscar.value.desdeFecha,
          this.formBuscar.value.hastaFecha
        )
        .subscribe({
          next: (datos) => {
            this._asientos = datos;
            this.asieFiltrados = [...datos];
            this.swbuscando = false;
            this.txtbuscar = 'Buscar';
          },
          error: (err) => {
            console.error(err.error);
            this.authService.mostrarError('Error al buscar Asientos', err.error);
          },
        });
    else {
      //Busca Comprobantes
      this.asiService
        .getComprobantes(
          2,
          this.formBuscar.value.tipcom,
          this.formBuscar.value.desdeNum,
          this.formBuscar.value.hastaNum,
          this.formBuscar.value.desdeFecha,
          this.formBuscar.value.hastaFecha
        )
        .subscribe({
          next: (datos) => {
            this._asientos = datos;
            this.swbuscando = false;
            this.txtbuscar = 'Buscar';
          },
          error: (err) => console.error(err.error),
        });
    }
  }

  comprobante(tipcom: number, compro: number) {
    if (tipcom == 1) return 'I-' + compro.toString();
    if (tipcom == 2) return 'E-' + compro.toString();
    if (tipcom == 3) return 'DC-' + compro.toString();
    if (tipcom == 4) return 'DI-' + compro.toString();
    if (tipcom == 5) return 'DE-' + compro.toString();
    return compro.toString();
  }

  public busquedainicial() {
    sessionStorage.removeItem('buscarAsientos');
    this.swdesdehasta = false;
    this.ultimoAsiento();
  }

  changeDesdeHasta() {
    this.swdesdehasta = true;
  }

  ordenarPor(campo: keyof AsientosVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }
    this.asieFiltrados.sort((a: any, b: any) => {
      let valorA: any;
      let valorB: any;
      switch (campo) {
        case 'documentonum':
          valorA = `${a.documento.nomdoc}.${a.numdoc}`;
          valorB = `${b.documento.nomdoc}.${b.numdoc}`;
          break;
        case 'beneficiario':
          valorA = a.beneficiario?.nomben;
          valorB = b.beneficiario?.nomben;
          break;
        // case 'responsable':
        //    valorA = a.beneficiariores?.nomben;
        //    valorB = b.beneficiariores?.nomben;
        //    break;
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

  filtrar(valor: any) {
    const filtro = valor.toLowerCase();
    if (!filtro) {
      if (this.asieFiltrados.length > 0) this.asieFiltrados = [...this._asientos];
      // this.calcTotales();
      return;
    }
    this.asieFiltrados = this._asientos.filter((a) => {
      const documentonum = `${a.documento.nomdoc} ${a.numdoc}`;
      const beneficiario = a.beneficiario.nomben;
      return [a.numero, a.fecha, documentonum, beneficiario, a.totdeb, a.totcre, a.concepto].some(
        (campo) => String(campo).toLowerCase().includes(filtro)
      );
    });
    // this.calcTotales();
  }

  onCellClick(event: any, asie: Asientos) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem(
        'asientoToTransacciones',
        JSON.stringify({ idasiento: asie.idasiento, padre: '/asientos' })
      );
      this.router.navigate(['transacciones']);
    }
  }

  nuevo() {
    this.router.navigate(['add-asiento']);
  }

  modiAsiento(idasiento: number) {
    sessionStorage.setItem('idasientoToModi', idasiento.toString());
    this.router.navigate(['/modi-asiento']);
  }

  cerrar() {
    this.router.navigate(['/inicio']);
  }

  retenciones(idasiento: number) {
    // console.log('idasiento: ', idasiento)
    // this.reteService.getByAsiento(idasiento).subscribe({
    //    next: datos => {
    //       const totrete = datos.length;
    //       switch (totrete) {
    //          case 0:
    //             sessionStorage.setItem("idasientoToRete", idasiento.toString());
    //             this.router.navigate(['/add-retencion']);
    //             break;
    //          case 1:
    //             // let retencionToModifi: { idasiento: number, idrete: number}
    //             let idrete = datos[0].idrete;
    //             // console.log('Envia: ', idasiento, ' y ', idrete)
    //             // let retencionToModifi = { idasiento: idasiento, idrete: idrete}
    //             // sessionStorage.setItem("retencionToModifi", JSON.stringify(retencionToModifi));
    //             sessionStorage.setItem("retencionToModifi", JSON.stringify({ idasiento: idasiento, idrete: idrete}));
    //             this.router.navigate(['/modi-retencion']);
    //             break;
    //          default:
    //             if (totrete > 1) {
    //                let idrete = datos[0].idrete;
    //                sessionStorage.setItem("idasientoToRete", idrete.toString());
    //                this.router.navigate(['/modi-retencion']);
    //             } else {
    //                console.error(`Total de retencines no válido (${totrete})`);
    //             }
    //       }
    //    },
    //    error: err => console.error('Al buscar la(s) retenciones: ', err.error)
    // });
  }

  eliminar(asiento: Asientos) {
    // this.sweliminar = false;
    // this.tranService.porIdasiento(asiento.idasiento).subscribe({
    //    next: resp => {
    //       this.sweliminar = !resp
    //       this.iAsiento.idasiento = asiento.idasiento;
    //       this.iAsiento.asiento = asiento.asiento;
    //    },
    //    error: err => console.error('Al buscar si el Asiento tiene Transacciones: ', err.error),
    // });
  }

  elimina() {
    // this.asiService.deleteAsiento(this.iAsiento.idasiento).subscribe({
    //    next: () => this.buscar(),
    //    error: err => console.error(err.error)
    // });
  }

  imprimir() {
    sessionStorage.setItem('asientosToImpExp', JSON.stringify(this.buscarAsientos));
    this.router.navigate(['/imp-asientos']);
  }
}

// interface interfaceAsiento {
//    idasiento: number;
//    asiento: number
// }

interface AsientosVisual {
  numero: number;
  fecha: Date;
  comprobante: string;
  documentonum: string;
  totdeb: number;
  totcre: number;
  swretencion: boolean;
  beneficiario: string;
  concepto: string;
}

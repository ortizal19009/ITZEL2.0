import { Component, OnInit } from '@angular/core';
import { Presupuesto } from '../../../modelos/contabilidad/presupuesto.model';
import { AbstractControl, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { of } from 'rxjs';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Transacciones } from '../../../modelos/contabilidad/transacciones.model';
import { Cuentas } from '../../../modelos/contabilidad/cuentas.model';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { Router } from '@angular/router';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { CommonModule } from '@angular/common';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';
import { PresupuestoService } from '../../../servicios/contabilidad/presupuesto.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { TransaccionesService } from '../../../servicios/contabilidad/transacciones.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EjecucionService } from '../../../servicios/contabilidad/ejecucion.service';

@Component({
  selector: 'app-modi-transaccion.component',
   imports: [ReactiveFormsModule, CommonModule, FormsModule, VisualFormatDirective],
  templateUrl: './modi-transaccion.component.html',
  styleUrl: './modi-transaccion.component.css'
})
export class ModiTransaccionComponent implements OnInit {

   idtransaccion!: number;
   formTransaccion!: FormGroup;
   idasiento!: number;
   iAsiento = {} as interfaceAsiento; //Interface para los datos del Asiento
   _cuentas: any[] = [];
   idcuenta!: number | null;
   _documentos: any[] = [];
   totDebe!: number;
   totHaber!: number;
   partida!: { idpresupuesto: number | null; codpar: String };

   constructor(private router: Router, private fb: FormBuilder, private asiService: AsientosService, public authService: AutorizaService,
      private cueService: CuentasService, private docuService: DocumentosService, private tranService: TransaccionesService,
      private presuService: PresupuestoService, private ejecuService: EjecucionService, private colorService: ColoresService) { }

   ngOnInit(): void {
      sessionStorage.setItem('ventana', '/transacciones');
      let coloresJSON = sessionStorage.getItem('/transacciones');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

      const datosToModiTransaccion = JSON.parse(sessionStorage.getItem("datosToModiTransaccion")!);
      this.idtransaccion = +datosToModiTransaccion.idtransaccion;
      this.idasiento = datosToModiTransaccion.idasiento;
      this.totDebe = +datosToModiTransaccion.totDebe;
      this.totHaber = +datosToModiTransaccion.totHaber;

      this.formTransaccion = this.fb.group({
         orden: ['', Validators.required],
         cuenta: ['', Validators.required, this.valCuenta.bind(this)],
         codcue: '',
         nomcue: [''],
         debcre: ['', Validators.required],
         valor: ['', [Validators.required, Validators.pattern(/^-?\d+(\.\d{1,2})?$/)]],
         documento: null,
         numdoc: ['', Validators.required],
         concepto: ['', Validators.required],

         usumodi: [this.authService.idusuario],
         fecmodi: [new Date()],
      },
         { updateOn: "blur" }
      );

      this.listarDocumentos();
      this.datosAsiento();
      this.buscaTransaccion();
   }

   colocaColor(colores: any) {
      document.documentElement.style.setProperty('--bgcolor1', colores[0]);
      const cabecera = document.querySelector('.cabecera');
      if (cabecera) cabecera.classList.add('nuevoBG1')
      document.documentElement.style.setProperty('--bgcolor2', colores[1]);
      const detalle = document.querySelector('.detalle');
      if (detalle) detalle.classList.add('nuevoBG2');
      this.colorForaneas();
   }

   async colorForaneas() {
      try {
         let datos: string;
         datos = await this.colorService.getcolor(this.authService.idusuario!, 'documentos');
         document.documentElement.style.setProperty('--bgcolor3', datos);
         const documentos = document.querySelector('.documentos');
         if (documentos) documentos.classList.add('nuevoBG3');
      } catch (error) {
         console.error(error);
      }
   }

   get f() { return this.formTransaccion.controls; }

   listarDocumentos() {
      this.docuService.getListaDocumentos().subscribe({
         next: (docu: Documentos[]) => this._documentos = docu,
         error: (err) => { console.error(err.error); this.authService.mostrarError('Error al recuperar Documentos', err.error) }
      });
   }

   datosAsiento() {
      this.asiService.obtenerPorIdasiento(this.idasiento).subscribe({
         next: (asie: Asientos) => {
            this.iAsiento.idasiento = asie.idasiento;
            this.iAsiento.asiento = asie.numero;
            this.iAsiento.fecha = asie.fecha;
            this.iAsiento.tipasi = asie.tipasi;
            this.iAsiento.comprobante = nomcomprobante(asie.tipcom) + asie.compro.toString();
            this.iAsiento.benefi = asie.beneficiario.nomben;
            this.iAsiento.documento = asie.documento.nomdoc + ' ' + asie.numdoc;
            this.iAsiento.intdoc = asie.documento.iddocumento!;
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar el Asiento', err.error) }
      });
   }

   buscaTransaccion() {
      this.tranService.getById(this.idtransaccion).subscribe({
         next: (transaccion: Transacciones) => {
            this.idcuenta = transaccion.cuenta.idcuenta!;
            this.formTransaccion.patchValue({
               orden: transaccion.orden,
               documento: transaccion.documento.iddocumento,
               numdoc: transaccion.numdoc,
               cuenta: transaccion.cuenta.codcue,
               codcue: transaccion.cuenta.codcue,
               nomcue: transaccion.cuenta.nomcue,
               debcre: transaccion.debcre,
               valor: transaccion.valor,
               concepto: transaccion.concepto
            });
         },
         error: err => console.error(err.error)
      });
   }

   cuentasxTiptran(e: any) {
      if (e.target.value != '') {
         this.cueService.findByTiptran(0, e.target.value).subscribe({
            next: datos => this._cuentas = datos,
            error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar las Cuentas', err.error) },
         });
      }
   }
   onCuentaSelected(e: any) {
      const selectedOption = this._cuentas.find((x: { codcue: any; }) => x.codcue === e.target.value);
      if (selectedOption) {
         this.idcuenta = selectedOption.idcuenta
         this.f['codcue'].setValue(selectedOption.codcue);
         this.f['nomcue'].setValue(selectedOption.nomcue);
         // if (selectedOption.asohaber.length > 6) {    //Ok asi porque asohaber no siempre es nulo
         //    this.presuService.getByCodpar(selectedOption.asohaber).subscribe({
         //       next: (partida: Presupuesto) => {
         //          if (partida) {
         //             this.partida = { idpresupuesto: partida.idpresupuesto, codpar: partida.codpar };
         //             this.formTransaccion.controls['codpar'].setValue(partida.codpar);
         //             this.formTransaccion.controls['nompar'].setValue(partida.nompar);
         //          }
         //          else this.partida = { idpresupuesto: null, codpar: '' };
         //       },
         //       error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar la Partida', err.error) }
         //    });
         // }
      }
      else {
         this.idcuenta = null;
         this.formTransaccion.controls['nomcue'].setValue('');
         this.partida = { idpresupuesto: null, codpar: '' };
      };
   }


   actualizar() {
      const docSeleccionado = this._documentos.find(d => d.iddocumento === this.formTransaccion.value.documento);
      let transaccion: Transacciones;
      transaccion = this.formTransaccion.value;
      //Tablas foraneas
      let asiento: Asientos = new Asientos();
      asiento.idasiento = this.idasiento;
      transaccion.asiento = asiento;

      transaccion.documento = docSeleccionado!;

      let cuenta: Cuentas = new Cuentas();
      cuenta.idcuenta = this.idcuenta!;
      transaccion.cuenta = cuenta;

      let beneficiario: Beneficiarios = new Beneficiarios();
      beneficiario.idbeneficiario = 1;
      transaccion.beneficiario = beneficiario;

      this.tranService.updateTransaccion(this.idtransaccion, transaccion).subscribe({
         next: transaci => {
            const newTransa = transaci as Transacciones;
            // if (this.partida.idpresupuesto && this.iAsiento.tipasi == 2) {
            //    const iEjecucio = {} as interfaceEjecucio; //Interface para guardar la Ejecución
            //    iEjecucio.codpar = this.partida.codpar;
            //    iEjecucio.fecha_eje = this.iAsiento.fecha;
            //    iEjecucio.tipeje = 3;
            //    iEjecucio.modifi = 0;
            //    iEjecucio.prmiso = 0;
            //    iEjecucio.devengado = newTransa.valor;
            //    iEjecucio.totdeven = 0;
            //    iEjecucio.cobpagado = 0;
            //    iEjecucio.concep = this.formTransaccion.value.descri;
            //    iEjecucio.usucrea = this.authService.idusuario!;
            //    iEjecucio.feccrea = newTransa.feccrea;
            //    iEjecucio.idasiento = this.iAsiento.idasiento;
            //    iEjecucio.inttra = newTransa.idtransaccion;
            //    // this.presupue.idpresupuesto = this.partida.idpresupuesto;
            //    // iEjecucio.idpresupuesto = this.presupue;
            //    const objEjecucio: any = iEjecucio;   //Ok para llamar como Objeto any (no se puede como Interface)
            //    // this.ejecuService.saveEjecucion(objEjecucio).subscribe({
            //    //    next: () => { },
            //    //    error: err => {console.error('Al guardar Ejecucio: ', err.error); this.authService.mostrarError('Error al guardar Ejecucion', err.error) }
            //    // });
            // }

            // if (this.formTransaccion.get('debcre')!.value == 1) this.totDebe = this.totDebe + +this.formTransaccion.get('valor')!.value
            // else this.totHaber = this.totHaber + +this.formTransaccion.get('valor')!.value
            this.totDebe = 100; this.totHaber = 100;
            this.asiService.updateTotdebAndTotcre(this.idasiento, +this.totDebe, +this.totHaber).subscribe({
               next: () => this.regresar(),
               error: err => { console.error('Al actualizar TotdebAndTotcre: ', err.error); this.authService.mostrarError('Error al actualizar total Asiento', err.error) }
            });
            this.regresar()
         },
         error: err => { console.error('Al guardar Transaci: ', err.error); this.authService.mostrarError('Error al guardar', err.error) }
      });
   }

   regresar() { this.router.navigate(['/transacciones']); }

   //Valida que se haya seleccionado una Cuenta
   valCuenta(control: AbstractControl) {
      if (this.idcuenta == null) return of({ 'invalido': true });
      else return of(null);
   }

   // decimalValidator(control: AbstractControl): ValidationErrors | null {
   //    const value = control.value;
   //    if (value === null || value === undefined || value === '') { return null; }
   //    const regex = /^-?\d{1,3}(,\d{3})*(\.\d{0,2})?$/;
   //    return regex.test(value) ? null : { invalidDecimal: true };
   // }

}

interface interfaceAsiento {
   idasiento: number;
   asiento: number;
   fecha: Date;
   tipasi: number;
   comprobante: string;
   documento: String;
   benefi: String;
   intdoc: number;
   concepto: string;
}

//Nombre Tipo de Comprobante
function nomcomprobante(tipcom: number): string {
   switch (tipcom) {
      case 1: return 'I-';
      case 2: return 'E-';
      case 3: return 'DC-';
      case 4: return 'DI-';
      case 5: return 'DE-';
      default: return '';
   }
}

interface interfaceEjecucio {
   inteje: number | null;
   codpar: String;
   fecha_eje: Date;
   tipeje: number;
   modifi: number;
   prmiso: number;
   totdeven: number;
   devengado: number;
   cobpagado: number;
   concep: string;
   usucrea: number;
   feccrea: Date;
   idasiento: number;
   inttra: number;
   idpresupuesto: Presupuesto;
}



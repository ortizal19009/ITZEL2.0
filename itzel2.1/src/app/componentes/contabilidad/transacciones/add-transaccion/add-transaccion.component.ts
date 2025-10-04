import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Presupuesto } from '../../../modelos/contabilidad/presupuesto.model';
import { Router } from '@angular/router';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { TransaccionesService } from '../../../servicios/contabilidad/transacciones.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EjecucionService } from '../../../servicios/contabilidad/ejecucion.service';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';
import { PresupuestoService } from '../../../servicios/contabilidad/presupuesto.service';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';
import { Transacciones } from '../../../modelos/contabilidad/transacciones.model';
import { of } from 'rxjs';
import { Cuentas } from '../../../modelos/contabilidad/cuentas.model';

@Component({
  selector: 'app-add-transaccion.component',
   imports: [ReactiveFormsModule, CommonModule, FormsModule],
  templateUrl: './add-transaccion.component.html',
  styleUrl: './add-transaccion.component.css'
})
export class AddTransaccionComponent implements OnInit {

   formTransaccion!: FormGroup;
   idasiento!: number;
   iAsiento = {} as interfaceAsiento; //Interface para los datos del Asiento
   _cuentas: any[] = [];
   idcuenta!: number | null;
   _documentos: any[] = [];
   totDebe!: number;
   totHaber!: number;
   partida!: { idpresupuesto: number | null; codpar: String };

   beneficiario: Beneficiarios = new Beneficiarios();
   presupue: Presupuesto = new Presupuesto();
   valCuenta: any;

   constructor(private router: Router, private fb: FormBuilder, private asiService: AsientosService, public authService: AutorizaService,
      private cueService: CuentasService, private docuService: DocumentosService, private tranService: TransaccionesService,
      private presuService: PresupuestoService, private ejecuService: EjecucionService, private colorService: ColoresService) { }

   ngOnInit(): void {
      sessionStorage.setItem('ventana', '/transacciones');
      let coloresJSON = sessionStorage.getItem('/transacciones');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

      const datosToAddtransaci = JSON.parse(sessionStorage.getItem("datosToAddtransaci")!);
      this.idasiento = datosToAddtransaci.idasiento;
      this.totDebe = +datosToAddtransaci.totDebe;
      this.totHaber = +datosToAddtransaci.totHaber;

      this.formTransaccion = this.fb.group({
         orden: [+datosToAddtransaci.orden, Validators.required],
         cuenta: ['', Validators.required, this.valCuenta.bind(this)],
         codcue: '',
         nomcue: ['', Validators.required],
         debcre: ['', Validators.required],
         valor: [0, [Validators.required, Validators.pattern(/^-?\d+(\.\d{1,2})?$/)]],
         documento: null,
         numdoc: ['', Validators.required],
         concepto: ['', Validators.required],

         usucrea: [this.authService.idusuario],
         feccrea: [new Date()],
      },
         { updateOn: "blur" }
      );

      this.listarDocumentos();
      this.datosAsiento();
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
            // console.log('this.iAsiento.intdoc: ', this.iAsiento.intdoc);
            // this.documento.iddocumento = this.iAsiento.intdoc;
            this.formTransaccion.patchValue({
               documento: this.iAsiento.intdoc,
               numdoc: asie.numdoc,
               concepto: asie.concepto
            });
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar el Asiento', err.error) }
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


   guardar() {
      const docSeleccionado = this._documentos.find(d => d.iddocumento === this.formTransaccion.value.documento);
      let newTransaccion: Transacciones;    //Para evitar los mensaje de validacion en el formulario
      newTransaccion = this.formTransaccion.value;
      //Tablas foraneas
      let asiento: Asientos = new Asientos();
      asiento.idasiento = this.idasiento;
      newTransaccion.asiento = asiento;

      newTransaccion.documento = docSeleccionado!;
      let cuenta: Cuentas = new Cuentas();
      cuenta.idcuenta = this.idcuenta!;
      newTransaccion.cuenta = cuenta;

      let beneficiario: Beneficiarios = new Beneficiarios();
      beneficiario.idbeneficiario = 1;
      newTransaccion.beneficiario = beneficiario;

      this.tranService.saveTransa(newTransaccion).subscribe({
         next: transaci => {
            const newTransa = transaci as Transacciones;
            if (this.partida.idpresupuesto && this.iAsiento.tipasi == 2) {
               const iEjecucio = {} as interfaceEjecucio; //Interface para guardar la Ejecución
               iEjecucio.codpar = this.partida.codpar;
               iEjecucio.fecha_eje = this.iAsiento.fecha;
               iEjecucio.tipeje = 3;
               iEjecucio.modifi = 0;
               iEjecucio.prmiso = 0;
               iEjecucio.devengado = newTransa.valor;
               iEjecucio.totdeven = 0;
               iEjecucio.cobpagado = 0;
               iEjecucio.concep = this.formTransaccion.value.descri;
               iEjecucio.usucrea = this.authService.idusuario!;
               iEjecucio.feccrea = newTransa.feccrea;
               iEjecucio.idasiento = this.iAsiento.idasiento;
               iEjecucio.inttra = newTransa.idtransaccion;
               this.presupue.idpresupuesto = this.partida.idpresupuesto;
               iEjecucio.idpresupuesto = this.presupue;
               const objEjecucio: any = iEjecucio;   //Ok para llamar como Objeto any (no se puede como Interface)
               // this.ejecuService.saveEjecucion(objEjecucio).subscribe({
               //    next: () => { },
               //    error: err => {console.error('Al guardar Ejecucio: ', err.error); this.authService.mostrarError('Error al guardar Ejecucion', err.error) }
               // });
            }

            if (this.formTransaccion.get('debcre')!.value == 1) this.totDebe = this.totDebe + +this.formTransaccion.get('valor')!.value
            else this.totHaber = this.totHaber + +this.formTransaccion.get('valor')!.value
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
alCuenta(control: AbstractControl) {
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

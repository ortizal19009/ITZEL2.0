import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { BenextranService } from '../../../servicios/contabilidad/benextran.service';
import { TransaccionesService } from '../../../servicios/contabilidad/transacciones.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { Cuentas } from '../../../modelos/contabilidad/cuentas.model';
import { Router } from '@angular/router';
import { Transacciones } from '../../../modelos/contabilidad/transacciones.model';
import { Benextran } from '../../../modelos/contabilidad/benextran.model';
import { of } from 'rxjs';

@Component({
  selector: 'app-add-benextran.component',
   imports: [ReactiveFormsModule, CommonModule, FormsModule, VisualFormatDirective],
  templateUrl: './add-benextran.component.html',
  styleUrl: './add-benextran.component.css'
})

export class AddBenextranComponent implements OnInit {

   iAsiento = {} as interfaceAsiento; //Interface para los datos del Asiento
   formTransaci!: FormGroup;
   idasiento!: number;
   _cuentas: any[] = [];
   idcuenta!: number | null;
   _documentos: any;
   totDebe!: number;
   totHaber!: number;
   tiptran!: { numero: number; nombre: string; cabecera1: string; cabecera2: string };
   _transaci: any;
   _arrBeneficiarios: any[] = [];
   arrIdbeneficiario: number[] | null[] = [];
   nomDebcre: string = 'Debe';

   
   documento: Documentos = new Documentos;
   beneficiario: Beneficiarios = new Beneficiarios;
   asiento: Asientos = new Asientos;

   constructor(private router: Router, private fb: FormBuilder, private coloresService: ColoresService, public authService: AutorizaService,
      private cueService: CuentasService, private asiService: AsientosService, private docuService: DocumentosService,
      private beneService: BeneficiariosService, private tranService: TransaccionesService, private benextranService: BenextranService) { }

   ngOnInit(): void {
      sessionStorage.setItem('ventana', '/benextran');
      let coloresJSON = sessionStorage.getItem('/benextran');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();

      const datosToAddtransaci = JSON.parse(sessionStorage.getItem("datosToAddtransaci")!);
      this.idasiento = datosToAddtransaci.idasiento;
      this.asiento.idasiento = this.idasiento;
      this.totDebe = +datosToAddtransaci.totDebe;
      this.totHaber = +datosToAddtransaci.totHaber;
      const tiptranInfo = nombreTiptran(datosToAddtransaci.tiptran);
      this.tiptran = { numero: datosToAddtransaci.tiptran, nombre: tiptranInfo.nombre, cabecera1: tiptranInfo.cabecera1, cabecera2: tiptranInfo.cabecera2 };
      let debcre = 1;   //tiptran 2,3 y 4 => Debe  5,6 y 7 Haber
      if (this.tiptran.numero > 4) { debcre = 2; this.nomDebcre = 'Haber'; };

      this.beneficiario.idbeneficiario = 1;
      
      this.formTransaci = this.fb.group({
         orden: +datosToAddtransaci.orden,
         cuenta: ['', Validators.required, this.valCuenta.bind(this)],
         codcue: '',
         nomcue: ['', Validators.required],
         debcre: debcre,
         valor: ['', Validators.required],
         documento: this.documento,
         numdoc: ['', Validators.required],
         idbene: this.beneficiario,
         asiento: this.asiento,
         tiptran: this.tiptran.numero,
         totbene: 0,
         concepto: '',
         swconcili: 0,
         usucrea: this.authService.idusuario,
         feccrea: new Date(),
         benextran: this.fb.array([])
      },
         { updateOn: "blur" }
      );

      this.datosAsiento();
      this.listarDocumentos();
   }

   async buscaColor() {
      try {
         const datos = await this.coloresService.setcolor(1, 'transaci');
         const coloresJSON = JSON.stringify(datos);
         sessionStorage.setItem('/transaci', coloresJSON);
         this.colocaColor(datos);
      } catch (error) {
         console.error(error);
      }
   }

   colocaColor(colores: any) {
      document.documentElement.style.setProperty('--bgcolor1', colores[0]);
      const cabecera = document.querySelector('.cabecera');
      if (cabecera) cabecera.classList.add('nuevoBG1')
      document.documentElement.style.setProperty('--bgcolor2', colores[1]);
      const detalle = document.querySelector('.detalle');
      if (detalle) detalle.classList.add('nuevoBG2');
   }

   get f() { return this.formTransaci.controls; }

   datosAsiento() {
      this.asiService.obtenerPorIdasiento(this.idasiento).subscribe({
         next: (asiento: Asientos) => {
            this.iAsiento.numero = asiento.numero;
            this.iAsiento.fecha = asiento.fecha;
            this.iAsiento.comprobante = nomcomprobante(asiento.tipcom) + asiento.compro.toString();
            this.iAsiento.beneficiario = asiento.beneficiario.nomben;
            this.iAsiento.documento = asiento.documento.nomdoc + ' ' + asiento.numdoc;
            this.iAsiento.numdoc = asiento.numdoc;
            this.iAsiento.iddocumento = asiento.documento.iddocumento!;
            this.documento.iddocumento = this.iAsiento.iddocumento;
            this.formTransaci.patchValue({
               documento: this.iAsiento.iddocumento,
               numdoc: asiento.numdoc,
               concepto: asiento.concepto,
            });
         },
         error: err => {console.error(err.error); this.authService.mostrarError('Error al buscar el Asiento', err.error)}
      });
   }

   listarDocumentos() {
      this.docuService.getListaDocumentos().subscribe({
         next: (documentos: Documentos[]) => this._documentos = documentos,
         error: (err) => {console.error(err.error); this.authService.mostrarError('Error al buscar Documentos', err.error)}
      });
   }

   cuentasxTiptran(e: any) {
      if (e.target.value != '') {
         this.cueService.findByTiptran(this.tiptran.numero, e.target.value).subscribe({
            next: (cuentas: Cuentas[]) => this._cuentas = cuentas,
            error: err => {console.error(err.error); this.authService.mostrarError('Error al buscar Cuentas por tiptran', err.error)},
         });
      }
   }
   onCuentaSelected(e: any) {
      const selectedOption = this._cuentas.find((x: { codcue: any; }) => x.codcue === e.target.value);
      if (selectedOption) {
         this.idcuenta = selectedOption.idcuenta;
         this.f['codcue'].setValue(selectedOption.codcue);
         this.formTransaci.controls['nomcue'].setValue(selectedOption.nomcue);
      }
      else {
         this.idcuenta = null;
         this.formTransaci.controls['nomcue'].setValue('');
      };
   }

   regresar() { this.router.navigate(['/transacciones']); }

   //Beneficiarios por Transacción
   get benextran(): FormArray { return this.formTransaci.get('benextran') as FormArray; }

   addBenextran() { this.benextran.push(this.agregaBenextran(this.benextran.length)); }

   agregaBenextran(indice: number): FormGroup {
      // console.log('Envia a valBenefi this.benextran.length: ', this.benextran.length)
      return this.fb.group({
         beneficiario: ['', [Validators.required], [this.valBenefi.bind(this, indice)]],  //No se sabe por qué pero al enviar el indice valida con la fila en la que se digita
         documento: this.iAsiento.iddocumento,
         numdoc: this.iAsiento.numdoc,
         // valor: [0, Validators.required],
         valor: [0, [Validators.required, Validators.min(0), Validators.pattern(/^-?\d+(\.\d{1,2})?$/)]],
         totpagcob: '',
         saldo: ''
      });
   }

   eliminaBenextran(index: number) {
      this.benextran.removeAt(index);
      this.changeValor();
   }

   benefixNombre(index: number, e: any) {
      if (!this._arrBeneficiarios[index]) { this._arrBeneficiarios[index] = []; }
      if (e.target.value != '') {
         this.beneService.findByNomben(e.target.value).subscribe({
            next: resp => this._arrBeneficiarios[index] = resp,
            error: err => console.error(err.error),
         });
      } else this._arrBeneficiarios[index] = [];
   }
   onBenefiSelected(index: number, e: any) {
      const selectedOption = this._arrBeneficiarios[index]?.find((x: { nomben: any; }) => x.nomben === e.target.value);
      if (selectedOption) this.arrIdbeneficiario[index] = selectedOption.idbeneficiario;
      else this.arrIdbeneficiario[index] = null;
   }

   changeValor() {
      let suma = 0
      for (let i = 0; i < this.benextran.length; i++) {
         const grupo = this.benextran.at(i) as FormGroup; // Obtiene el FormGroup en el índice i
         const valor = grupo.get('valor')?.value;
         if (this.arrIdbeneficiario[i] != null) {
            suma = suma + valor;
         }
      }
      if (suma != 0) this.formTransaci.controls['valor'].setValue(suma)
      else this.formTransaci.controls['valor'].setValue(null)
   }

   guardar() {
      let cuenta: Cuentas = new Cuentas;
      cuenta.idcuenta = this._cuentas[0].idcuenta;
      this.formTransaci.value.cuenta = cuenta;

      const docSeleccionado: Documentos | undefined = this._documentos.find((d: Documentos) => d.iddocumento === this.formTransaci.value.documento);
      this.formTransaci.value.documento = docSeleccionado;

      this.formTransaci.value.totbene = this.benextran.length;
      this.beneficiario.idbeneficiario = this.arrIdbeneficiario[0]!;  //Coloca al primero como Beneficiario en transaci
      this.formTransaci.value.beneficiario = this.beneficiario;

      this.tranService.saveTransa(this.formTransaci.value).subscribe({
         next: transaci => {
            //Añade Beneficiario(s) (benextran)
            const _transaci = transaci as Transacciones;
            
            for (let i = 0; i < this.benextran.length; i++) {
               let itemGroup = this.benextran.at(i) as FormGroup;
               let benextran: Benextran = new Benextran()
               benextran.transaccion = _transaci;

               this.beneficiario.idbeneficiario = this.arrIdbeneficiario[i]!;
               benextran.beneficiario = this.beneficiario;

               this.documento.iddocumento = itemGroup.get('documento')!.value;
               benextran.documento = this.documento;

               let numdoc = itemGroup.get('numdoc')!.value;
               benextran.numdoc = numdoc;
               benextran.valor = itemGroup.get('valor')!.value;
               benextran.totpagcob = 0;
               benextran.pagocobro = 0;
               benextran.usucrea = this.authService.idusuario!;
               benextran.feccrea = new Date();
               this.benextranService.saveBenextran(benextran).subscribe({
                  // next: () => {},
                  error: err => {console.error('Al guardar en benextran:', err.error); this.authService.mostrarError('Error al guardar Benextran', err.error)}
               });
            }
            //Actualiza Totales del Asiento
            if (this.formTransaci.get('debcre')!.value == 1) this.totDebe = this.totDebe + +this.formTransaci.get('valor')!.value
            else this.totHaber = this.totHaber + +this.formTransaci.get('valor')!.value
            this.asiService.updateTotdebAndTotcre(this.idasiento, this.totDebe, this.totHaber).subscribe({
               next: () => this.regresar(),
               error: err => {console.error('Al actualizar totales del asiento:', err.error); this.authService.mostrarError('Al actualizar totales del Asiento', err.error)}
            });
         },
         error: err => { console.error('Al guardar la Transaccion:', err.error); this.authService.mostrarError('Al guardar la Transaccion', err.error) }
      });
   }

   //Valida Cuenta
   valCuenta() {
      if (this.idcuenta == null) return of({ 'invalido': true });
      else return of(null);
   }

   //Valida Beneficiario
   valBenefi(i: number) {
      if (this.arrIdbeneficiario[i] == null) return of({ 'invalido': true });
      else return of(null);
   }

}

interface interfaceAsiento {
   numero: number;
   fecha: Date;
   comprobante: string;
   documento: String;
   numdoc: String;
   beneficiario: String;
   iddocumento: number;
}

//Nombre Tipo de Comprobante
function nomcomprobante(tipcom: number): string {
   if (tipcom == 1) return 'I-';
   if (tipcom == 2) return 'E-';
   if (tipcom == 3) return 'DC-';
   if (tipcom == 4) return 'DI-';
   if (tipcom == 5) return 'DE-';
   return '';
}

// interface interfaceBenextran {
//    idbenxtra: number;
//    idtransaccion: Transacciones;
//    idbeneficiario: Beneficiarios;
//    iddocumento: Documentos;
//    numdoc: string;
//    valor: number;
//    totpagcob: number;
//    pagocobro: number;
//    idpresupuesto: number;
//    codparreci: string;
//    codcuereci: string;
//    asierefe: number;
// }

function nombreTiptran(tiptran: number): { nombre: string, cabecera1: string, cabecera2: string } {
   if (tiptran == 2) return { nombre: 'Registro de Anticipo(s)', cabecera1: 'Anticipo', cabecera2: 'Liquidado' };
   if (tiptran == 3) return { nombre: 'Registro de Cuenta(s) por cobrar', cabecera1: 'Cuenta por cobrar', cabecera2: 'Cobrado' };
   if (tiptran == 4) return { nombre: 'Registro de Cuenta(s) por cobrar año anterior', cabecera1: 'Valor', cabecera2: 'Cobrado' };
   if (tiptran == 5) return { nombre: 'Registro de Depósitos y fondos de terceros', cabecera1: 'Valor', cabecera2: 'Liquidado' };
   if (tiptran == 6) return { nombre: 'Registro de Cuenta(s) por pagar', cabecera1: 'Cuenta por Pagar', cabecera2: 'Pagado' };
   if (tiptran == 7) return { nombre: 'Registro de Cuenta(s) por pagar año anterior', cabecera1: 'Valor', cabecera2: 'Pagado' };
   return { nombre: '(Ninguno)', cabecera1: ' ', cabecera2: ' ' };
}

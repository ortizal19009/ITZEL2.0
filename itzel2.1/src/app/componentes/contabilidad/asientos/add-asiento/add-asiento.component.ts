import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Router } from '@angular/router';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { Proyectos } from '../../../modelos/contabilidad/proyectos.model';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';
import { map, of } from 'rxjs';

@Component({
  selector: 'app-add-asiento.component',
   imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './add-asiento.component.html',
  styleUrl: './add-asiento.component.css'
})
export class AddAsientoComponent implements OnInit {

   formAsiento!: FormGroup;
   tipcom!: number;
   _documentos: Documentos[] = [];
   idproyecto: number | null = null;
   _proyectos: any[] = [];
   idbeneficiario: number | null = null;
   _beneficiarios: Beneficiarios[] = [];

   tiposAsiento = [
      { tipasi: 1, icono: 'bi bi-door-open', nombre: 'Apertura' },
      { tipasi: 2, icono: 'bi-cash-stack', nombre: 'Financiero' },
      { tipasi: 3, icono: 'bi-sliders', nombre: 'Ajuste' },
      { tipasi: 4, icono: 'bi-list-check', nombre: 'Orden' },
      { tipasi: 5, icono: 'bi bi-door-closed', nombre: 'Cierre' },
   ]
   comprobantes = [
      { tipcom: 1, icono: 'bi-arrow-down-right-circle', nombre: 'Ingreso' },
      { tipcom: 2, icono: 'bi-arrow-up-left-circle', nombre: 'Egreso' },
      { tipcom: 3, icono: 'bi-calendar-day', nombre: 'Diario Contabilidad' },
      { tipcom: 4, icono: 'bi-arrow-down-right-square', nombre: 'Diario Ingreso' },
      { tipcom: 5, icono: 'bi-arrow-down-left-square', nombre: 'Diario Egreso' },
   ]

   // documento: Documentos = new Documentos;
   // beneficiario: Beneficiarios = new Beneficiarios;

   constructor(private router: Router, private fb: FormBuilder, private beneService: BeneficiariosService, private colorService: ColoresService,
      private proyService: ProyectosService, public authService: AutorizaService,
      private docuService: DocumentosService, private asiService: AsientosService) { }

   ngOnInit(): void {
      sessionStorage.setItem('ventana', '/asientos');
      let coloresJSON = sessionStorage.getItem('/asientos');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

      const fechaObj: Date = new Date();
      const fecha = fechaObj.toISOString().substring(0, 10);
      this.formAsiento = this.fb.group({
         fecha: [fecha, Validators.required, this.valAño.bind(this)],
         tipasi: 2,
         nombretipo: 'Financiero',
         tipcom: ['', [Validators.required]],
         nombrecompro: '',
         compro: ['', Validators.required, this.valCompro.bind(this)],
         numdoc: ['', [Validators.required]],
         proyecto: ['', [Validators.required], [this.valProyecto.bind(this)]],
         nombre: '',
         beneficiario: ['', [Validators.required], [this.valBeneficiario.bind(this)]],
         concepto: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(254)]],

         documento: null,

         usucrea: this.authService.idusuario,
         feccrea: [new Date()]
      },
         { updateOn: "blur" });

      this.ultimafecha();
      this.listarDocumentos();
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

   get f() { return this.formAsiento.controls; }

   ultimafecha() {
      this.asiService.obtenerUltimaFecha().subscribe({
         next: x => this.formAsiento.patchValue({ fecha: x }),
         error: err => { console.error('Error al obtener la última fecha', err.error); this.authService.mostrarError('Error Última Fecha', err.error) }
      });
   }

   changeTipo(tipo: any) {
      this.f['tipasi'].setValue(tipo.tipasi);
      this.f['nombretipo'].setValue(tipo.nombre);
   }

   changeComprobante(comp: any) {
      this.f['nombrecompro'].setValue(comp.nombre);
      this.f['tipcom'].setValue(comp.tipcom);
      let ultimoCompro: number;
      this.tipcom = comp.tipcom;
      this.asiService.obtenerUltimoCompro(this.tipcom).subscribe({
         next: resp => {
            ultimoCompro = resp;
            this.formAsiento.patchValue({ compro: ultimoCompro + 1 })
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error Último Comprobante', err.error) }
      });
   }

   listarDocumentos() {
      this.docuService.getListaDocumentos().subscribe({
         next: datos => {
            this._documentos = datos;
            this.formAsiento.patchValue({ documento: 1 });
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error listar Documentos', err.error) }
      });
   }

   //Datalist de los Proyectos
   proyectoxCodigo(e: any) {
      if (e.target.value != '') {
         this.proyService.proyectosPorCodigo(e.target.value).subscribe({
            next: (proyectos: Proyectos[]) => this._proyectos = proyectos,
            error: err => { console.error(err.error); this.authService.mostrarError('Error Proyectos por código', err.error); },
         });
      }
   }
   onProyectoSelected(e: any) {
      const selectedOption = this._proyectos.find((x: { codigo: any; }) => x.codigo === e.target.value);
      if (selectedOption) {
         this.formAsiento.controls['nombre'].setValue(selectedOption.nombre);
         this.idproyecto = selectedOption.idproyecto;
      }
      else {
         this.formAsiento.controls['nombre'].setValue('');
         this.idproyecto = null;
      }
   }

   //Datalist de los Beneficiarios
   beneficiariosxNomben(e: any) {
      if (e.target.value != '') {
         this.beneService.findByNomben(e.target.value).subscribe({
            next: (beneficiarios: Beneficiarios[]) => this._beneficiarios = beneficiarios,
            error: err => {
               console.error(err.error); this.authService.mostrarError('Error Beneficiarios por nombre', err.error);
            },
         });
      }
   }
   onBeneficiarioSelected(e: any) {
      const selectedOption = this._beneficiarios.find((x: { nomben: any; }) => x.nomben === e.target.value);
      if (selectedOption) this.idbeneficiario = selectedOption.idbeneficiario;
      else this.idbeneficiario = null
   }

   guardar() {
      this.asiService.siguienteNumero().subscribe(numero => {
         const siguienteNumero = numero;
         this.formAsiento.value.numero = siguienteNumero;
         let newAsiento: Asientos;    //Para evitar los mensaje de validacion en el formulario
         newAsiento = this.formAsiento.value;
         //Tablas foráneas
         const docSeleccionado = this._documentos.find(d => d.iddocumento === this.formAsiento.value.documento);
         newAsiento.documento = docSeleccionado!;

         let proyecto: Proyectos = new Proyectos();
         proyecto.idproyecto = this.idproyecto!;
         newAsiento.proyecto = proyecto;

         let beneficiario: Beneficiarios = new Beneficiarios();
         beneficiario.idbeneficiario = this.idbeneficiario!;
         newAsiento.beneficiario = beneficiario;
         //Campos obligatorios que no están en el formulario
         newAsiento.totdeb = 0;
         newAsiento.totcre = 0;
         newAsiento.swretencion = false;
         newAsiento.cerrado = false;

         this.asiService.saveAsiento(newAsiento).subscribe({
            next: () => {
               //Actualiza los datos de búsqueda para que se muestre en la lista
               let buscaDesdeNum = siguienteNumero - 16;
               if (buscaDesdeNum <= 0) buscaDesdeNum = 1;
               let year = new Date(this.f['fecha'].value).getFullYear(); // Extraer el año de la fecha 
               // console.log('year: ', year);
               const buscarAsientos = {
                  tipcom: 0,
                  desdeNum: buscaDesdeNum,
                  hastaNum: siguienteNumero,
                  desdeFecha: year.toString() + "-01-01",
                  hastaFecha: year.toString() + "-12-31",
               };
               sessionStorage.setItem("buscarAsientos", JSON.stringify(buscarAsientos));
               this.regresar();
            },
            error: err => { console.error(err.error); this.authService.mostrarError('Error al guardar', err.error) },
         });
      });
   }

   regresar() { this.router.navigate(['/asientos']); }

   //Valida el año de la fecha
   valAño(control: AbstractControl) {
      const empresa = this.authService.getDatosEmpresa()
      const año = empresa!.fechap.toString().slice(0, 4);
      const año1 = control.value.toString().slice(0, 4);
      if (año != año1) return of({ 'añoinvalido': true });
      else return of(null);
   }

   //Valida que no exista el comprobante para el tipo de comprobante
   valCompro(control: AbstractControl) {
      return this.asiService.valCompro(this.tipcom, control.value)
         .pipe(
            map(result => result ? { existe: true } : null)
         );
   }

   //Valida que se haya seleccionado un Proyecto
   valProyecto(control: AbstractControl) {
      if (this.idproyecto == null) return of({ 'invalido': true });
      else return of(null);
   }

   //Valida que se haya seleccionado un Beneficiario
   valBeneficiario(control: AbstractControl) {
      if (this.idbeneficiario == null) return of({ 'invalido': true });
      else return of(null);
   }

}

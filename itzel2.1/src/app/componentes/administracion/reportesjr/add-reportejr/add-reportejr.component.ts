import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ReportesjrService } from '../../../servicios/administracion/reportesjr.service';
import { RepoxopcionService } from '../../../servicios/administracion/repoxopcion.service';
import { map, of } from 'rxjs';

@Component({
   selector: 'app-add-reportejr',
   imports: [ReactiveFormsModule, CommonModule],
   templateUrl: './add-reportejr.component.html',
   styleUrl: './add-reportejr.component.css'
})

export class AddReportejrComponent implements OnInit {

   formReportejr!: FormGroup;
   idrepoxopcion: number | null = null;
   _repoxopcion: any[] = [];
   jrxmlFile: File | null = null;
   jasperFile: File | null = null;

   jrxmlFileName: string | null = null;
   
   fileLabel!: string;

   constructor(public router: Router, public fb: FormBuilder, public authService: AutorizaService,
      private repoxopService: RepoxopcionService, private repojrService: ReportesjrService) { }

   ngOnInit(): void {
      if (!this.authService.sessionlog) { this.router.navigate(['/inicio']); }
      sessionStorage.setItem('ventana', '/reportesjr');
      let coloresJSON = sessionStorage.getItem('/reportesjr');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

      let date: Date = new Date();
      this.formReportejr = this.fb.group({
         repoxopcion: ['', [Validators.required], [this.valRepoxopcion.bind(this)]],
         nombre: ['', Validators.required],
         archivos: [null,  this.validaArchivos.bind(this)],
         nomrep: ['', [Validators.required], [this.valNomrep.bind(this)]],
         desrep: ['', Validators.required],

         usucrea: this.authService.idusuario,
         feccrea: date,
      },
         { updateOn: "blur" }
      );
   }

   colocaColor(colores: any) {
      document.documentElement.style.setProperty('--bgcolor1', colores[0]);
      const cabecera = document.querySelector('.cabecera');
      if (cabecera) cabecera.classList.add('nuevoBG1')
      document.documentElement.style.setProperty('--bgcolor2', colores[1]);
      const detalle = document.querySelector('.detalle');
      if (detalle) detalle.classList.add('nuevoBG2');
   }

   get f() { return this.formReportejr.controls; }

   //Datalist de Repoxopcion
   repoxopcionxCodigo(e: any) {
      if (e.target.value != '') {
         this.repoxopService.obtenerPorCodigo(e.target.value).subscribe({
            next: datos => this._repoxopcion = datos,
            error: err => {
               console.error(err.error);
               this.authService.mostrarError('Error al buscar en Repoxopcion', err.error);
            },
         });
      }
   }
   onRepoxopcionSelected(e: any) {
      // console.log(e)
      const selectedOption = this._repoxopcion.find((x: { codigo: any; }) => x.codigo === e.target.value);
      if (selectedOption) {
         this.idrepoxopcion = selectedOption.idrepoxopcion;
         console.log('this.idrepoxopcion: ', this.idrepoxopcion)
         this.formReportejr.controls['nombre'].setValue(selectedOption.nombre);
      } else {
         this.formReportejr.controls['nombre'].setValue('');
         this.idrepoxopcion = null;
      }
   }

   onFilesSelected(event: any): void {
      const files: FileList = event.target.files;
      this.jrxmlFile = null;
      this.jasperFile = null;
      const selectedNames: string[] = [];

      for (let i = 0; i < files.length; i++) {
         const file = files[i];
         const ext = file.name.split('.').pop()?.toLowerCase();
         selectedNames.push(file.name);

         if (ext === 'jrxml') {
            this.jrxmlFile = file;

            // 🧠 Extraer nombre base sin extensión
            const nomrepSinExtension = file.name.replace(/\.[^/.]+$/, '');

            // 🧩 Asignar automáticamente al campo nomrep
            const control = this.formReportejr.get('nomrep');
            control?.setValue(nomrepSinExtension, { emitEvent: true });
            control?.markAsTouched();
            control?.updateValueAndValidity({ onlySelf: true });
         }

         else if (ext === 'jasper') {
            this.jasperFile = file;
         }
      }

      this.fileLabel = selectedNames.join(', ');

      // 🧩 Actualizar el control 'archivos' con ambos archivos
      this.formReportejr.get('archivos')?.setValue({
         jrxml: this.jrxmlFile,
         jasper: this.jasperFile
      });
      this.formReportejr.get('archivos')?.markAsTouched();
      this.formReportejr.get('archivos')?.updateValueAndValidity();
   }

   regresar() { this.router.navigate(['/reportesjr']); }

   guardar(): void {
      if (!this.jrxmlFile || !this.jasperFile) {
         // this.mensaje = 'Debe seleccionar ambos archivos (JRXML y Jasper)';
         return;
      }

      this.repojrService.uploadReporte(
         this.idrepoxopcion!,
         this.formReportejr.value.nomrep,
         this.formReportejr.value.desrep,
         this.jrxmlFile,
         this.jasperFile,
      ).subscribe({
         next: (res) => {
            // console.log('Respuesta del backend:', res);
            // this.mensaje = 'Reporte cargado correctamente ✅';
            this.formReportejr.reset(); // limpia el formulario
            this.jrxmlFile = null!;
            this.jasperFile = null!;

            this.regresar();
         },

         error: (err) => {
            console.error('Error al subir:', err);
            this.authService.mostrarError('Error al guardar', err.error)
            // this.mensaje = 'Error al cargar el reporte ❌: ' + (err.error?.message || err.message);
         },
      });
   }

   //Valida que se haya seleccionado una Opción
   valRepoxopcion(control: AbstractControl) {
      if (this.idrepoxopcion == null) return of({ 'invalido': true });
      else return of(null);
   }

   //Valida la selección de archivos
   validaArchivos(control: AbstractControl): ValidationErrors | null {
      const files = control.value;
      // Validación 1: existencia del objeto
      if (!files || typeof files !== 'object') { return { archivosIncompletos: true }; }
      const { jrxml, jasper } = files;
      // Validación 2: presencia de ambos archivos
      if (!jrxml || !jasper) { return { archivosIncompletos: true }; }
      // Validación 3: exceso de archivos (si se pasó un array por error)
      if (Array.isArray(files) && files.length > 2) { return { excesoArchivos: true }; }
      // Validación 4: coincidencia de nombre base
      const baseJrxml = jrxml.name.replace(/\.jrxml$/i, '');
      const baseJasper = jasper.name.replace(/\.jasper$/i, '');
      if (baseJrxml !== baseJasper) { return { nombresNoCoinciden: true }; }
      return null;
   }

   //Valida nomrep
   valNomrep(control: AbstractControl) {
      return this.repojrService.valNomrep(control.value).pipe(
         map(result => result ? { existe: true } : null)
      );
   }

}

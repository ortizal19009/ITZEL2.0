import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { map, of } from 'rxjs';
import Swal from 'sweetalert2';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ReportesjrService } from '../../../servicios/administracion/reportesjr.service';
import { RepoxopcionService } from '../../../servicios/administracion/repoxopcion.service';
import { CommonModule } from '@angular/common';
import { Reportesjr } from '../../../modelos/administracion/reportesjr.model';
@Component({
  selector: 'app-modi-reportejr',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './modi-reportejr.component.html',
  styleUrl: './modi-reportejr.component.css',
})
export class ModiReportejrComponent implements OnInit {
  idreporte!: number;
  formReportejr!: FormGroup;
  idrepoxopcion?: number | null = null;
  _repoxopcion: any[] = [];
  jrxmlFile: File | null = null;
  jasperFile: File | null = null;
  // jrxmlFileName: string | null = null;
  fileLabel!: string;

  constructor(
    public router: Router,
    public fb: FormBuilder,
    public authService: AutorizaService,
    private repoxopService: RepoxopcionService,
    private repojrService: ReportesjrService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/reportesjr');
    let coloresJSON = sessionStorage.getItem('/reportesjr');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    this.idreporte = +sessionStorage.getItem('idreporteToModi')!;
    // sessionStorage.removeItem("idreporteToModi") //

    const fechaObj: Date = new Date();
    const fecha = fechaObj.toISOString().substring(0, 10);
    this.formReportejr = this.fb.group(
      {
        repoxopcion: ['', [Validators.required], [this.valRepoxopcion.bind(this)]],
        nombre: ['', Validators.required],
        // archivos: [null, this.validaArchivos.bind(this)],
        archivos: [null],
        // nomrep: ['', [Validators.required], [this.valNomrep.bind(this)]],
        nomrep: [''],
        desrep: ['', Validators.required],

        usumodi: this.authService.idusuario,
        fecmodi: fechaObj,
      },
      { updateOn: 'blur' }
    );
    this.buscaReportejr();
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  get f() {
    return this.formReportejr.controls;
  }

  buscaReportejr() {
    this.repojrService.getById(this.idreporte).subscribe({
      next: (repojr: Reportesjr) => {
        this.idrepoxopcion = repojr.repoxopcion!.idrepoxopcion;
        this.formReportejr.patchValue({
          nombre: repojr.repoxopcion?.nombre,
          repoxopcion: repojr.repoxopcion?.codigo,
          nomrep: repojr.nomrep,
          desrep: repojr.desrep,
        });
      },
      error: (err) => console.error(err.error),
    });
  }

  //Datalist de Repoxopcion
  repoxopcionxCodigo(e: any) {
    if (e.target.value != '') {
      this.repoxopService.obtenerPorCodigo(e.target.value).subscribe({
        next: (datos) => (this._repoxopcion = datos),
        error: (err) => {
          console.error(err.error);
          this.authService.mostrarError('Error al buscar en Repoxopcion', err.error);
        },
      });
    }
  }
  onRepoxopcionSelected(e: any) {
    // console.log(e)
    const selectedOption = this._repoxopcion.find(
      (x: { codigo: any }) => x.codigo === e.target.value
    );
    if (selectedOption) {
      this.idrepoxopcion = selectedOption.idrepoxopcion;
      console.log('this.idrepoxopcion: ', this.idrepoxopcion);
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
      } else if (ext === 'jasper') {
        this.jasperFile = file;
      }
    }

    this.fileLabel = selectedNames.join(', ');

    // 🧩 Actualizar el control 'archivos' con ambos archivos
    this.formReportejr.get('archivos')?.setValue({
      jrxml: this.jrxmlFile,
      jasper: this.jasperFile,
    });
    this.formReportejr.get('archivos')?.markAsTouched();
    this.formReportejr.get('archivos')?.updateValueAndValidity();
  }

  regresar() {
    this.router.navigate(['/reportesjr']);
  }

  actualizar() {
    if (this.jrxmlFile == null || this.jasperFile == null) {
      this.actualizarMetadatos();
    } else {
      this.axtualizarCompleto();
    }
  }

  // A actualiza solo los metadatos, sin archivos
  actualizarMetadatos() {
    this.repojrService
      .actualizarMetadatos(this.idreporte, {
        idrepoxopcion: this.idrepoxopcion!,
        nomrep: this.formReportejr.value.nomrep,
        desrep: this.formReportejr.value.desrep,
      })
      .subscribe({
        next: () => {
          this.swal('success', 'Reporte actualizado con exito');
          this.regresar();
        },
        error: (err) => {
          console.error('Error al actualizar metadatos', err);
          this.authService.mostrarError('Error al actualizar metadatos', err.error);
        },
      });
  }

  // A actualiza todo, incluidos los archivos
  axtualizarCompleto(): void {
    this.repojrService
      .actualizarCompleto(this.idreporte, {
        idrepoxopcion: this.idrepoxopcion!,
        nomrep: this.formReportejr.value.nomrep,
        desrep: this.formReportejr.value.desrep,
        jrxml: this.jrxmlFile!,
        jasper: this.jasperFile!,
      })
      .subscribe({
        next: () => {
          this.swal('success', 'Archivos del reporte actualizados con exito');
          this.regresar();
        },
        error: (err) => {
          console.error('Error al actualizar metadatos', err);
          this.authService.mostrarError('Error al actualizar metadatos', err.error);
        },
      });
  }

  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top',
      showConfirmButton: false,
      timer: 2000,
    });
  }

  //Valida que se haya seleccionado una Opción
  valRepoxopcion(control: AbstractControl) {
    if (this.idrepoxopcion == null) return of({ invalido: true });
    else return of(null);
  }

  //Valida la selección de archivos
  validaArchivos(control: AbstractControl): ValidationErrors | null {
    const files = control.value;
    // Validación 1: existencia del objeto
    if (!files || typeof files !== 'object') {
      return { archivosIncompletos: true };
    }
    const { jrxml, jasper } = files;
    // Validación 2: presencia de ambos archivos
    if (!jrxml || !jasper) {
      return { archivosIncompletos: true };
    }
    // Validación 3: exceso de archivos (si se pasó un array por error)
    if (Array.isArray(files) && files.length > 2) {
      return { excesoArchivos: true };
    }
    // Validación 4: coincidencia de nombre base
    const baseJrxml = jrxml.name.replace(/\.jrxml$/i, '');
    const baseJasper = jasper.name.replace(/\.jasper$/i, '');
    if (baseJrxml !== baseJasper) {
      return { nombresNoCoinciden: true };
    }
    return null;
  }

  //Valida nomrep
  valNomrep(control: AbstractControl) {
    return this.repojrService
      .valNomrep(control.value)
      .pipe(map((result) => (result ? { existe: true } : null)));
  }
}

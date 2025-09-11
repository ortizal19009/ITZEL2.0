import { Component } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ReportesService } from '../../../servicios/administracion/reportes.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-reporte-update.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './reporte-update.component.html',
  styleUrl: './reporte-update.component.css'
})
export class ReporteUpdateComponent {
  form: FormGroup;
  jrxmlFile?: File;
  jasperFile?: File;
  mensaje = '';

  constructor(private fb: FormBuilder, private reporteService: ReportesService) {
    this.form = this.fb.group({
      nombre: ['', Validators.required],
      descripcion: ['', Validators.required]
    });
  }

  onFileSelected(event: any, type: string): void {
    const file = event.target.files[0];
    if (type === 'jrxml') {
      this.jrxmlFile = file;
    } else if (type === 'jasper') {
      this.jasperFile = file;
    }
  }

onSubmit(): void {
  if (!this.jrxmlFile || !this.jasperFile) {
    this.mensaje = 'Debe seleccionar ambos archivos (JRXML y Jasper)';
    return;
  }

  this.reporteService.uploadReporte(
    this.form.value.nombre,
    this.form.value.descripcion,
    this.jrxmlFile,
    this.jasperFile
  ).subscribe({
    next: (res) => {
      console.log('Respuesta del backend:', res);
      this.mensaje = 'Reporte cargado correctamente ✅';
      this.form.reset(); // limpia el formulario
      this.jrxmlFile = null!;
      this.jasperFile = null!;
    },
    error: (err) => {
      console.error('Error al subir:', err);
      this.mensaje = 'Error al cargar el reporte ❌: ' + (err.error?.message || err.message);
    }
  });
}

}

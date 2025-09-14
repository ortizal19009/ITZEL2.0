import { Component, OnInit } from '@angular/core';
import { ReportesService } from '../../../servicios/administracion/reportes.service';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { RouterLink } from '@angular/router';
@Component({
  selector: 'app-reportes.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, RouterLink],
  templateUrl: './reportes.component.html',
  styleUrl: './reportes.component.css',
})
export class ReportesComponent implements OnInit {
  reportes: any[] = [];
  mensaje = '';
  parametros: any[] = [];
  report!: FormGroup;
  reporteSeleccionado!: any;
  extension: string = 'pdf';

  constructor(private reporteService: ReportesService, private fb: FormBuilder) {}

  ngOnInit(): void {
    this.report = this.fb.group({});
    this.cargarReportes();
    this.crearFormulario(this.parametros);
  }

  cargarReportes(): void {
    this.reporteService.getReportes().subscribe({
      next: (data: any) => {
        this.reportes = data;
      },
      error: (err: any) => (this.mensaje = 'Error al cargar reportes: ' + err.message),
    });
  }
  ejecutarReporte(reporte: any): void {
    this.parametros = [];
    this.reporteSeleccionado = reporte;
    // Convierte el objeto en array [{nombre, tipo}]
    console.log(reporte.parametros);
    if (reporte.parametros) {
      this.parametros = Object.entries(reporte.parametros).map(([nombre, tipo]) => ({
        nombre,
        tipo,
      }));
    }

    console.log('Parametros procesados:', this.parametros);

    this.crearFormulario(this.parametros);
  }

  crearFormulario(params: any[]): void {
    const group: { [key: string]: FormControl } = {};

    params.forEach((param) => {
      console.log('Creando control para:', param);

      switch (param.tipo) {
        case 'java.lang.String':
          group[param.nombre] = new FormControl('');
          break;

        case 'java.lang.Integer':
          group[param.nombre] = new FormControl(0);
          break;

        case 'java.util.Date':
          group[param.nombre] = new FormControl('');
          break;

        case 'java.lang.Boolean':
          group[param.nombre] = new FormControl(false);
          break;

        default:
          group[param.nombre] = new FormControl('');
      }
    });

    this.report = this.fb.group(group);
  }

  onSubmit() {
    const valores = this.report.value;
    console.log(this.report.value);
    console.log(this.reporteSeleccionado);
    console.log(this.extension);
    const dto = {
      reportName: this.reporteSeleccionado.nombre, // 👈 debes guardar el reporte seleccionado
      parametros: valores,
      extension: this.extension,
    };

    this.reporteService.ejecutarReporteDB(dto).subscribe({
      next: (data: Blob) => {
        let tipo = 'application/pdf';
        if (dto.extension === 'xlsx')
          tipo = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        if (dto.extension === 'csv') tipo = 'text/plain';

        const blob = new Blob([data], { type: tipo });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `reporte.${dto.extension}`;
        a.click();
        window.URL.revokeObjectURL(url);
      },
      error: (err) => console.error('Error al ejecutar reporte:', err),
    });
  }
}

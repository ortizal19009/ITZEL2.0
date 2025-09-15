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
  swViewer: boolean = true;
  swVerReporte?: boolean;

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
    this.swViewer = false;
    const valores = this.report.value;
    console.log(this.swVerReporte);
    // Armamos los parámetros con nombre, tipo y valor
    const parametrosConTipo = this.parametros.map((p) => ({
      name: p.nombre,
      type: p.tipo,
      value: valores[p.nombre],
    }));

    const dto = {
      reportName: this.reporteSeleccionado.nombre,
      parameters: parametrosConTipo, // 👈 ya tiene name, type, value
      extension: this.extension,
    };

    this.reporteService.ejecutarReporteDB(dto).subscribe({
      next: (data: Blob) => {
        let tipo = 'application/pdf';
        if (dto.extension === 'xlsx') {
          tipo = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
          this.swVerReporte = true;
        }
        if (dto.extension === 'csv') {
          tipo = 'text/plain';
          this.swVerReporte = true;
        }

        const blob = new Blob([data], { type: tipo });

        if (this.swVerReporte) {
          console.log(this.swVerReporte);
          const url = window.URL.createObjectURL(blob);
          const a = document.createElement('a');
          a.click();
          window.URL.revokeObjectURL(url);
          a.href = url;
          a.download = `reporte.${dto.extension}`;
        } else {
          const url = URL.createObjectURL(blob);
          const pdfViewer = document.getElementById('pdfViewer') as HTMLIFrameElement;
          pdfViewer.src = url;
        }
      },
      error: (err) => console.error('Error al ejecutar reporte:', err),
    });
  }
  eliminar(reporte: any) {
    console.log(reporte);
    this.reporteService.deleteReporte(reporte.idreporte).subscribe({
      next: (dato: any) => {
        this.cargarReportes();
      },
      error: (e: any) => console.error(e),
    });
  }
}

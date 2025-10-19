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
    if (reporte.parametros) {
      this.parametros = Object.entries(reporte.parametros).map(([nombre, tipo]) => ({
        nombre,
        tipo,
      }));
    }
    this.crearFormulario(this.parametros);
  }

  crearFormulario(params: any[]): void {
    const group: { [key: string]: FormControl } = {};

    params.forEach((param) => {
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
          this.swVerReporte = true;
          tipo = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        } else if (dto.extension === 'csv') {
          this.swVerReporte = true;
          tipo = 'text/csv'; // más correcto que text/plain
        }

        const blob = new Blob([data], { type: tipo });
        const url = window.URL.createObjectURL(blob);

        if (this.swVerReporte) {
          // 👉 descarga directa
          const a = document.createElement('a');
          a.href = url;
          a.download = `reporte.${dto.extension}`;
          document.body.appendChild(a); // ⚡️ necesario
          a.click();
          document.body.removeChild(a); // limpiar
          window.URL.revokeObjectURL(url);
        } else {
          // 👉 mostrar en el visor PDF embebido
          const pdfViewer = document.getElementById('pdfViewer') as HTMLIFrameElement;
          if (pdfViewer) {
            pdfViewer.src = url;
          }
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

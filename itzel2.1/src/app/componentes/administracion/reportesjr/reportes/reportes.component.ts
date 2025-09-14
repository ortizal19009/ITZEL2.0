import { Component, OnInit } from '@angular/core';
import { ReportesService } from '../../../servicios/administracion/reportes.service';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-reportes.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './reportes.component.html',
  styleUrl: './reportes.component.css',
})
export class ReportesComponent implements OnInit {
  reportes: any[] = [];
  mensaje = '';

  constructor(private reporteService: ReportesService) {}

  ngOnInit(): void {
    this.cargarReportes();
  }

  cargarReportes(): void {
    this.reporteService.getReportes().subscribe({
      next: (data: any) => {
        console.log(data);
        this.reportes = data;
      },
      error: (err: any) => (this.mensaje = 'Error al cargar reportes: ' + err.message),
    });
  }

  ejecutarReporte(reporte: any): void {
    const params: any = {};

    // si el reporte tiene parámetros, aquí podrías mostrar un modal dinámico
    if (reporte.parametros) {
      const parsed = JSON.parse(reporte.parametros);
      parsed.forEach((p: any) => {
        const valor = prompt(`Ingrese valor para ${p.nombre} (${p.tipo})`);
        params[p.nombre] = valor;
      });
    }

    this.reporteService.ejecutarReporte(reporte.id, params).subscribe({
      next: (pdf: any) => {
        const blob = new Blob([pdf], { type: 'application/pdf' });
        const url = window.URL.createObjectURL(blob);
        window.open(url, '_blank');
      },
      error: (err: any) => (this.mensaje = 'Error al ejecutar reporte: ' + err.message),
    });
  }
}

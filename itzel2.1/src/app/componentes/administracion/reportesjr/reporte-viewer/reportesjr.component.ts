import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ParametroReporte } from '../../../modelos/administracion/reportes.model';
import { ReportesService } from '../../../servicios/administracion/reportes.service';

@Component({
  selector: 'app-reportesjr.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './reportesjr.component.html',
  styleUrl: './reportesjr.component.css'
})
export class ReportesjrComponent implements OnInit {
form!: FormGroup;
  parametros?: ParametroReporte[] = [];
  nombreReporte = '';

  constructor(
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private reporteService: ReportesService
  ) {}

  ngOnInit(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.reporteService.getReporte(id).subscribe(reporte => {
      this.nombreReporte = reporte.nombre;

      // Parsear parámetros JSON
      this.parametros = JSON.parse(reporte.parametros);

      // Construir formulario dinámico
      const group: any = {};
      this.parametros?.forEach((p:any) => {
        group[p.nombre] = ['']; // valor inicial vacío
      });
      this.form = this.fb.group(group);
    });
  }

  generarReporte(): void {
    console.log('Valores:', this.form.value);
    // Aquí llamas a tu endpoint de "ejecutar reporte" con los parámetros
  }
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { EstructuraService } from '../../../../servicios/contabilidad/estructura.service';
import { ProyectosService } from '../../../../servicios/contabilidad/proyectos.service';
import { jsPDF } from 'jspdf';
import { PdfService } from '../../../../servicios/reportes/pdf.service';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-imp-proyecto',
  imports: [FormsModule, CommonModule, RouterLink,
ReactiveFormsModule],
  templateUrl: './imp-proyecto.component.html',
  styleUrl: './imp-proyecto.component.css',
})
export class ImpProyectoComponent implements OnInit {
  f_reporte!: FormGroup;
  pdfSrc: SafeResourceUrl | null = null; // Cambia a SafeResourceUrl
  pdfViwer: boolean = false;

  _estructura?: any;
  listaReportes: any[] = [
    {
      value: 0,
      nombre: 'Todos los proyectos',
    },
    {
      value: 1,
      nombre: 'Proyectos por nivel',
    },
    {
      value: 2,
      nombre: 'Proyectos por grupo',
    },
  ];
  datosImprimir: any = [];
  constructor(
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectoService: ProyectosService,
    private pdfService: PdfService,
    private sanitizer: DomSanitizer
  ) {}
  ngOnInit(): void {
    this.f_reporte = this.fb.group({
      reporte: 0,
      nivel: 0,
      grupo: '',
    });
    this.getEstructura();
  }
  getEstructura() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (datos: any) => {
        this._estructura = datos;
        this.f_reporte.patchValue({
          nivel: datos[0],
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  getAllProyectos(doc: any, header: any) {
    this.proyectoService.proyectosGetAll().subscribe({
      next: async (datos: any) => {
        datos.forEach(async (item: any) => {
          await this.datosImprimir.push([
            item.codigo,
            item.nombre,
            item.movimiento,
            item.idestructura.nombre,
            item.idestructura.nivel,
          ]);
        });
        this.pdfService.pdfOneTable(doc, header, this.datosImprimir);
      },
      error: (e: any) => console.error(e),
    });
  }
  getProyectosByNivel(doc: any, header: any) {
    let nivel = this.f_reporte.value.nivel;
    this.proyectoService.getProyectosByNivel(nivel.nivel).subscribe({
      next: async (datos: any) => {
        datos.forEach(async (item: any) => {
          await this.datosImprimir.push([
            item.codigo,
            item.nombreproyecto,
            item.movimiento,
            item.nombreestructura,
            item.nivel,
          ]);
        });
        this.pdfService.pdfOneTable(doc, header, this.datosImprimir);
      },
      error: (e: any) => console.error(e),
    });
  }
  getProyectosByGrupo(doc: any, header: any) {
    let codigo = this.f_reporte.value.grupo;
    this.proyectoService.getProyectosByGrupo(codigo).subscribe({
      next: async (datos: any) => {
        datos.forEach(async (item: any) => {
          await this.datosImprimir.push([
            item.codigo,
            item.nombreproyecto,
            item.movimiento,
            item.nombreestructura,
            item.nivel,
          ]);
        });
        this.pdfService.pdfOneTable(doc, header, this.datosImprimir);
      },
      error: (e: any) => console.error(e),
    });
  }
  onSubmit() {
    this.pdfSrc = '';
    this.pdfViwer = true;
    let opt: number = this.f_reporte.value.reporte;
    let nombre: string = this.f_reporte.value.nombre;
    const doc = new jsPDF();
    switch (opt) {
      case 0:
        this.datosImprimir = [];
        const header: any[] = [
          ['Lista proyectos'],
          ['Código', 'Nombre', 'Movimiento', 'Estructura', 'Nivel'],
        ];
        try {
          this.getAllProyectos(doc, header);
        } catch (e: any) {
          console.error(e);
        }
        break;
      case 1:
        this.datosImprimir = [];
        const header_1: any[] = [
          ['Lista proyectos por nivel'],
          ['Código', 'Nombre', 'Movimiento', 'Estructura', 'Nivel'],
        ];
        try {
          this.getProyectosByNivel(doc, header_1);
        } catch (e: any) {
          console.error(e);
        }
        break;
      case 2:
        this.datosImprimir = [];
        const header_2: any[] = [
          ['Lista proyectos por Grupo'],
          ['Código', 'Nombre', 'Movimiento', 'Estructura', 'Nivel'],
        ];
        try {
          this.getProyectosByGrupo(doc, header_2);
        } catch (e: any) {
          console.error(e);
        }
        break;
    }
  }
  jasperReport() {
    this.pdfViwer = false;
    let opt: number = this.f_reporte.value.reporte;
    let nombre: string = this.f_reporte.value.nombre;
    const doc = new jsPDF();
    switch (opt) {
      case 0:
        this.proyectoService.getAllProyectosReport().subscribe({
          next: (datos: any) => {
            const blob = new Blob([datos], { type: 'application/pdf' });
            const url = window.URL.createObjectURL(blob);
            this.pdfSrc = this.sanitizer.bypassSecurityTrustResourceUrl(url);
          },
          error: (e: any) => console.error(e),
        });

        break;
      case 1:
        this.proyectoService
          .getByNivelProyectosReport(+this.f_reporte.value.nivel.nivel!)
          .subscribe({
            next: (datos: any) => {
              const blob = new Blob([datos], { type: 'application/pdf' });
              const url = window.URL.createObjectURL(blob);
              this.pdfSrc = this.sanitizer.bypassSecurityTrustResourceUrl(url);
            },
            error: (e: any) => console.error(e),
          });
        break;
      case 2:
        this.proyectoService
          .getCogigoProyectosReport(this.f_reporte.value.grupo)
          .subscribe({
            next: (datos: any) => {
              const blob = new Blob([datos], { type: 'application/pdf' });
              const url = window.URL.createObjectURL(blob);
              this.pdfSrc = this.sanitizer.bypassSecurityTrustResourceUrl(url);
            },
            error: (e: any) => console.error(e),
          });
        break;
    }
  }
}

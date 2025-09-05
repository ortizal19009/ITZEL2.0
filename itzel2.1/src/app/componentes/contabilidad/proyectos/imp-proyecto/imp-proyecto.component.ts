import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { EstructuraService } from '../../../servicios/contabilidad/estructura.service';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
import { PdfService } from '../../../servicios/reportes/pdf.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { jsPDF } from 'jspdf';
import { JasperreportService } from '../../../servicios/reportes/jasperreport.service';
@Component({
  selector: 'app-imp-proyecto',
  imports: [FormsModule, CommonModule, ReactiveFormsModule, RouterLink],
  templateUrl: './imp-proyecto.component.html',
  styleUrl: './imp-proyecto.component.css',
})
export class ImpProyectoComponent implements OnInit {
  f_reporte!: FormGroup;
  pdfSrc: SafeResourceUrl | null = null; // Cambia a SafeResourceUrl
  pdfViwer: boolean = false;
  title: string = 'Imprimir reportes proyectos';
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
    private proyectoService: ProyectoService,
    private pdfService: PdfService,
    private sanitizer: DomSanitizer,
    private jasperService: JasperreportService
  ) { }
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
            item.estructura.nombre,
            item.estructura.nivel,
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
  _jasperReport() {
    this.pdfViwer = false;
    let opt: number = this.f_reporte.value.reporte;
    let nombre: string = this.f_reporte.value.nombre;
    const doc = new jsPDF();
    console.log(opt);

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
        this.proyectoService.getCogigoProyectosReport(this.f_reporte.value.grupo).subscribe({
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
  jasperReport() {
    this.pdfViwer = false;
    let opt: number = this.f_reporte.value.reporte;
    let f: any = this.f_reporte.value;
    console.log(opt);
    let body: any;
    switch (opt) {
      case 0:
        body = {
          reportName: "listaProyectos",
          extencion: ".pdf"
        };

        this.jasperService.getReporteOfJasper(body).then((blob: Blob) => {
          setTimeout(() => {
            const file = new Blob([blob], { type: 'application/pdf' });
            const fileURL = URL.createObjectURL(file);

            // Asignar el blob al iframe
            const pdfViewer = document.getElementById(
              'pdfViewer'
            ) as HTMLIFrameElement;

            if (pdfViewer) {
              pdfViewer.src = fileURL;
            }
          }, 500);
        }).catch((e: any) => {
          console.error(e);
        });

        break;
      case 1:
        body = {
          reportName: "listaProyectosByNivel",
          parameters: {
            nivel: f.nivel.nivel
          },
          extencion: ".pdf"
        };

        this.jasperService.getReporteOfJasper(body).then((blob: Blob) => {
          setTimeout(() => {
            const file = new Blob([blob], { type: 'application/pdf' });
            const fileURL = URL.createObjectURL(file);

            // Asignar el blob al iframe
            const pdfViewer = document.getElementById(
              'pdfViewer'
            ) as HTMLIFrameElement;

            if (pdfViewer) {
              pdfViewer.src = fileURL;
            }
          }, 500);
        }).catch((e: any) => {
          console.error(e);
        });
        break;
      case 2:
        console.log(f.grupo)
        body = {
          reportName: "listaProyectosByGrupo",
          parameters: {
            codigo: f.grupo
          },
          extencion: ".pdf"
        };

        this.jasperService.getReporteOfJasper(body).then((blob: Blob) => {
          setTimeout(() => {
            const file = new Blob([blob], { type: 'application/pdf' });
            const fileURL = URL.createObjectURL(file);

            // Asignar el blob al iframe
            const pdfViewer = document.getElementById(
              'pdfViewer'
            ) as HTMLIFrameElement;

            if (pdfViewer) {
              pdfViewer.src = fileURL;
            }
          }, 500);
        }).catch((e: any) => {
          console.error(e);
        });
        break;
    }
  }
}

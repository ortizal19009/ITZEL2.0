import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { EstructuraService } from '../../../servicios/contabilidad/estructura.service';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { PdfService } from '../../../servicios/reportes/pdf.service';
import { CommonModule } from '@angular/common';
import { Route, Router, RouterLink } from '@angular/router';
import { jsPDF } from 'jspdf';
import { JasperreportService } from '../../../servicios/reportes/jasperreport.service';
import Swal from 'sweetalert2';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
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
    {
      value: 3,
      nombre: 'Ifinan',
    },
    {
      value: 4,
      nombre: 'Ifinan 2',
    },
  ];
  listaExtenciones: any[] = [
    {
      value: 0,
      nombre: '.pdf',
    },
    {
      value: 1,
      nombre: '.xlsx',
    },
    {
      value: 2,
      nombre: '.csv',
    },
  ];
  datosImprimir: any = [];
  constructor(
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectosService: ProyectosService,
    private pdfService: PdfService,
    private sanitizer: DomSanitizer,
    private jasperService: JasperreportService,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private router: Router
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/imp-proyecto');
      let coloresJSON = sessionStorage.getItem('/imp-proyecto');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }

    this.f_reporte = this.fb.group({
      reporte: 0,
      nivel: 0,
      grupo: '',
      extencion: '.pdf',
    });
    this.getEstructura();
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'imp-proyecto');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/imp-proyecto', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error('Al buscar la ventana: ', error);
    }
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
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
    this.proyectosService.proyectosGetAll().subscribe({
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
    this.proyectosService.getProyectosByNivel(nivel.nivel).subscribe({
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
    this.proyectosService.getProyectosByGrupo(codigo).subscribe({
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
    let f: any = this.f_reporte.value;
    let body: any;
    switch (opt) {
      case 0:
        body = {
          reportName: 'listaProyectos',
          extencion: f.extencion,
        };

        this.buildReport(body);

        break;
      case 1:
        body = {
          reportName: 'listaProyectosByNivel',
          parameters: {
            nivel: f.nivel.nivel,
          },
          extencion: f.extencion,
        };

        this.buildReport(body);

        break;
      case 2:
        body = {
          reportName: 'listaProyectosByGrupo',
          parameters: {
            codigo: f.grupo,
          },
          extencion: f.extencion,
        };
        this.buildReport(body);

        break;
      case 3:
        body = {
          reportName: 'ifinan1',
          extencion: f.extencion,
        };
        this.buildReport(body);

        break;
      case 4:
        body = {
          reportName: 'ifinan',
          parameters: {
            limit: 10,
          },
          extencion: f.extencion,
        };
        this.buildReport(body);

        break;
    }
  }
  buildReport(body: any) {
    this.jasperService
      .getReporteOfJasper(body)
      .then((datos: Blob) => {
        const fileType =
          body.extencion === '.csv'
            ? 'text/csv'
            : body.extencion === '.xlsx'
            ? 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            : 'application/pdf';

        const fileName = body.reportName + body.extencion;

        const blob = new Blob([datos], { type: fileType });

        if (body.extencion === '.pdf') {
          // mostrar PDF en iframe
          const url = URL.createObjectURL(blob);
          const pdfViewer = document.getElementById('pdfViewer') as HTMLIFrameElement;
          if (pdfViewer) pdfViewer.src = url;
        } else {
          // descargar CSV o XLSX
          const link = document.createElement('a');
          link.href = URL.createObjectURL(blob);
          link.download = fileName;
          link.click();
          URL.revokeObjectURL(link.href);
        }
      })
      .catch((e: any) => console.error(e));
  }

  swalerta(data: any) {
    Swal.fire({
      title: 'vista reporte',
      html: ``,
    });
  }
}

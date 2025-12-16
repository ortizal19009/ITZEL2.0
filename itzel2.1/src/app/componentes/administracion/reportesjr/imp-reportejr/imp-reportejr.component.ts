import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import Swal from 'sweetalert2';
import { Repoxopcion } from '../../../modelos/administracion/repoxopcion.model';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { JasperreportService } from '../../../servicios/reportes/jasperreport.service';
import { RepoxopcionService } from '../../../servicios/administracion/repoxopcion.service';
import { ReportesjrService } from '../../../servicios/administracion/reportesjr.service';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-imp-reportejr',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './imp-reportejr.component.html',
  styleUrl: './imp-reportejr.component.css'
})

export class ImpReportejrComponent implements OnInit {

  formImprimir!: FormGroup;
  swimprimir: boolean = true;
  opcreporte: number = 1;
  repoxopcion: Repoxopcion[] = [];
  swbotones: boolean = false;
  swcalculando: boolean = false;
  txtcalculando = 'Calculando';

  pdfViwer: boolean = false;
  private reporteUrl: string | null = null; // URL temporal del Blob

  parametros: any[] = [];
  extension: string = 'pdf';
  swVerReporte?: boolean;
  swparametros: boolean = false;

  reportejr!: any;
  nomrep!: string;

  constructor(public fb: FormBuilder, private router: Router, public authService: AutorizaService, private repojrService: ReportesjrService,
    private jasperService: JasperreportService, private repoxopService: RepoxopcionService) { }

  ngOnInit(): void {
    if (!this.authService.sessionlog) { this.router.navigate(['/inicio']); }
    sessionStorage.setItem('ventana', '/reportesjr');
    let coloresJSON = sessionStorage.getItem('/reportesjr');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    const reportejrJSON = sessionStorage.getItem('reportejrToImpExp');
    if (reportejrJSON) {
      this.reportejr = JSON.parse(reportejrJSON);
      // console.log('this.reportejr: ', this.reportejr);
      this.nomrep = this.reportejr.nomrep!;
      const jrxmlBase64 = this.reportejr.jrxml!;
      const xmlString = decodeBase64ToXml(jrxmlBase64);
      const nombreReporte = extractReportNameFromJrxml(xmlString);
      // console.log('Nombre del reporte:', nombreReporte);
      this.formImprimir = this.fb.group({
        opcion: this.reportejr.repoxopcion!.opcion,
        nomopcion: this.reportejr.repoxopcion!.nombre,
        // nomrep: this.reportejr.nomrep,
        desrep: this.reportejr.desrep,
        jrxml: nombreReporte,
        nombrearchivo: ['', [Validators.required, Validators.minLength(3)]],
        extencion: '.pdf',
      });
      this.verificaParametros()
    }
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1')
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  get f() { return this.formImprimir.controls; }

  verificaParametros() {
    const raw = this.reportejr?.parametros;
    this.swparametros = false;
    let parsed: any = {};
    if (raw) {
      try {
        parsed = typeof raw === 'string' ? JSON.parse(raw) : raw;
        this.swparametros = parsed && typeof parsed === 'object' && Object.keys(parsed).length > 0;
        this.parametrosFormulario(parsed);
      } catch {
        this.swparametros = false;
      }
    }
  }

  parametrosFormulario(params: any): void {
    this.parametros = Object.entries(params)
      .map(([nombre, valor]) => {
        const [tipo, anchoCampoStr, ordenStr] = (valor as string).split('|');
        const anchoCampo = parseInt(anchoCampoStr, 10) || 12;
        const orden = parseInt(ordenStr, 10) || 999;
        return { nombre, tipo, anchoCampo, orden };
      })
      .sort((a, b) => a.orden - b.orden); // Ordena por 'orden'

    // console.log('this.parametros: ', this.parametros);
    // console.log('this.proyectosToImpExp: ', this.proyectosToImpExp);
    this.parametros.forEach((param) => {
      let valorInicial: any;
      // const existe = Object.keys(this.reportejr).find(k => k.toLowerCase() === param.nombre.toLowerCase());
      switch (param.tipo) {
        case 'java.lang.String':
          valorInicial = '';
          break;
        case 'java.lang.Integer':
          valorInicial = 0;
          break;
        case 'java.util.Date':
          // valorInicial = convertirFechaISO('01/01/2025');
          break;
        case 'java.lang.Boolean':
          valorInicial = false;
          break;
        default:
          valorInicial = '';
      }
      this.formImprimir.addControl(param.nombre, new FormControl(valorInicial));
    });
  }

  impriexpor() { this.swimprimir = !this.swimprimir; }

  retornar() { this.router.navigate(['/reportesjr']); }

  generarJasper() {
    this.swbotones = true;
    const valores = this.formImprimir.value;

    // Arma los parámetros con nombre, tipo y valor
    const parametrosConTipo = this.parametros.map((p: any) => ({
      name: p.nombre,
      type: p.tipo,
      value: valores[p.nombre],
    }));

    const dto = {
      reportName: this.reportejr.nomrep,
      parameters: parametrosConTipo,
      extension: this.extension,
    };
    console.log('dto: ', dto);
    this.repojrService.ejecutarReporteDB(dto).subscribe({
      next: (data: Blob) => {
        let tipo = 'application/pdf';
        if (dto.extension === 'xlsx') { tipo = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'; }
        if (dto.extension === 'csv') { tipo = 'text/plain'; }

        const blob = new Blob([data], { type: tipo });

        this.reporteUrl = URL.createObjectURL(blob); // Guardar la URL temporal
        this.swcalculando = false;
        this.txtcalculando = this.swimprimir ? 'Mostrar' : 'Descargar';

      },
      error: (err: any) => {
        console.error('Error al ejecutar reporte:', err.error);
        this.authService.mostrarError('Error al Generar el reporte: ', err);
      }
    });
  }



  // Genera el reporte y lo guarda this.reporteUrl
  async generateReportOld(body: any) {
    try {
      this.swbotones = true;
      const datos: Blob = await this.jasperService.getReporteOfJasper(body);

      const fileType =
        body.extencion === '.csv' ? 'text/csv' :
          body.extencion === '.xlsx' ? 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' :
            'application/pdf';

      const blob = new Blob([datos], { type: fileType });
      this.reporteUrl = URL.createObjectURL(blob); // Guardar la URL temporal
      // console.log('Reporte generado, listo para mostrar.');

      this.swcalculando = false;
      this.txtcalculando = this.swimprimir ? 'Mostrar' : 'Descargar';
    } catch (e) {
      console.error(e);
    }
  }

  // Mostrar el reporte en un modal con iframe cuando el usuario presione un botón
  showReport() {
    if (!this.reporteUrl) {
      console.warn('Primero se debe generar el reporte.');
      return;
    }
    Swal.fire({
      title: 'Visor de Reportes',
      width: '90%',
      html: `<iframe src="${this.reporteUrl}" width="100%" height="560px" style="border:none;"></iframe>`,
      showCloseButton: true,
      showConfirmButton: false,
      allowOutsideClick: false,
      customClass: {
        popup: 'swaimprimir',
        title: 'swafantacyblack',
      }
    }).then(() => {
      // Liberar memoria si ya no se va a volver a mostrar
      URL.revokeObjectURL(this.reporteUrl!);
      this.reporteUrl = null;
      this.swbotones = false;
    });
  }

  buildReportOld(body: any) {
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
        const url = URL.createObjectURL(blob);

        if (body.extencion === '.pdf') {
          Swal.fire({
            title: 'Visor de Reportes',
            width: '70%',
            html: `<iframe src="${url}" width="100%" height="560px" style="border:none;"></iframe>`,
            showCloseButton: true,
            showConfirmButton: false,
            allowOutsideClick: false,
            customClass: {
              popup: 'swaimprimir',
              title: 'swafantacyblack',
            }
          }).then(() => {
            URL.revokeObjectURL(url);
          });
        } else {
          // descargar CSV o XLSX
          const link = document.createElement('a');
          link.href = url;
          link.download = fileName;
          link.click();
          URL.revokeObjectURL(url);
        }
      })
      .catch((e: any) => console.error(e));
  }

  async imprimir() {
    this.swbotones = true;
    this.swcalculando = true;
    // let fecha = this.formImprimir.value.fecha;
    switch (this.opcreporte) {
      case 1:  //Lista
        try {
          // this._usuarios = await this.repoService.getUsuariosAsync()
          this.swcalculando = false;
          if (this.swimprimir) this.txtcalculando = 'Mostrar'
          else this.txtcalculando = 'Descargar'
        } catch (error) {
          console.error('Error al obtener las cuentas:', error);
        }
        break;
      case 2:  //Detalle
        try {
          let codcue = this.formImprimir.value.codcue;
          let nomcue = this.formImprimir.value.nomcue;
          // this._cuentas = await this.usuService.getByCodigoyNombreAsync(codcue, nomcue);
          // let i = 0
          // this.saldos(0);
          // console.log('Después de this.saldos(i)')
          this.swcalculando = false;
          if (this.swimprimir) this.txtcalculando = 'Mostrar'
          else this.txtcalculando = 'Descargar'
        } catch (error) {
          console.error('Error al obtener los Usuarios:', error);
        }
        break;
      case 3:  //Usuarios uno
        this.swcalculando = false;
        if (this.swimprimir) this.txtcalculando = 'Mostrar'
        else this.txtcalculando = 'Descargar'
    }
  }

}

function decodeBase64ToXml(base64: string): string {
  const binary = atob(base64); // decodifica Base64 a string binario
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }
  const decoder = new TextDecoder('utf-8');
  return decoder.decode(bytes);
}

function extractReportNameFromJrxml(xmlString: string): string | null {
  const parser = new DOMParser();
  const doc = parser.parseFromString(xmlString, 'application/xml');
  const jasperReport = doc.getElementsByTagName('jasperReport')[0];
  return jasperReport?.getAttribute('name') ?? null;
}

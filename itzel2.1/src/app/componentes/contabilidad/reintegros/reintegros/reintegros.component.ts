import { Component } from '@angular/core';
import { Certificaciones } from '../../../modelos/contabilidad/certificaciones.model';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { CertificacionesService } from '../../../servicios/contabilidad/certificaciones.service';
import { Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-reintegros.component',
  imports: [RouterLink, CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './reintegros.component.html',
  styleUrl: './reintegros.component.css',
})
export class ReintegrosComponent {
  title: string = 'Reintegros';
  formBuscar!: FormGroup;
  swbuscando?: boolean;
  txtbuscar: string = 'Buscar';
  certificacionesFiltradas: any[] = [];
  _certificaciones: any[] = [];
  ordenColumna: keyof CertificacionVisual = 'fecha';
  ordenAscendente: boolean = true;
  today = new Date().toISOString().substring(0, 10); // ejemplo: "2025-09-19"

  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private elimService: EliminadosService,
    private s_certificaciones: CertificacionesService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    const date = new Date();
    date.setDate(date.getDate() - 20); // restar 20 días

    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/certificaciones');
      let coloresJSON = sessionStorage.getItem('/certificaciones');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.formBuscar = this.fb.group({
      min: 0,
      max: 0,
      fechaInicio: date.toISOString().substring(0, 10),
      fechaFin: [this.today],
      filtroControl: '',
    });
    this.getLastCertificacion();
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(
        this.authService.idusuario!,
        'certificaciones'
      );
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/certificaciones', coloresJSON);
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
  buscar() {
    let f = this.formBuscar.value;
    this.s_certificaciones.getByNumDate(2, f.fechaInicio, f.fechaFin, f.min, f.max).subscribe({
      next: (datos: any) => {
        if (datos.length === 0) {
          this.authService.mostrarError('No se encontraron registros', 'Atención');
        }
        //this._certificaciones = datos;
        this.certificacionesFiltradas = [...datos];
      },
      error: (e: any) => console.error(e.error),
    });
  }
  cerrar() {
    this.router.navigate(['/inicio']);
  }
  getLastCertificacion() {
    this.s_certificaciones.findLastByTipo(2).subscribe({
      next: (certificacion: Certificaciones) => {
        if (certificacion !== null) {
          let minimo = certificacion.numero - 20;
          if (minimo <= 0) {
            minimo = 1;
          }
          this.formBuscar.patchValue({
            min: minimo,
            max: certificacion.numero,
          });
        }
      },
    });
  }
  ordenarPor(campo: keyof CertificacionVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.certificacionesFiltradas.sort((a: any, b: any) => {
      const valorA = a[campo];
      const valorB = b[campo];

      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;

      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';

      if (esNumero) {
        return this.ordenAscendente ? valorA - valorB : valorB - valorA;
      } else {
        return this.ordenAscendente
          ? String(valorA).localeCompare(String(valorB))
          : String(valorB).localeCompare(String(valorA));
      }
    });
  }
  filtrar(valor: any) {
    if (valor) {
      this.certificacionesFiltradas = [...this._certificaciones]; // si está vacío, muestro todos
      return;
    }

    const filter = valor.toLowerCase();
    this.certificacionesFiltradas = this._certificaciones.filter(
      (certificaciones) =>
        certificaciones.fecha?.toLowerCase().includes(filter) || // ejemplo campo nombre
        certificaciones.beneficiario?.toLowerCase().includes(filter) ||
        certificaciones.responsable?.toLowerCase().includes(filter)
    );
  }
}
interface CertificacionVisual {
  fecha: Date;
  beneficiario: string;
  responsable: string;
}

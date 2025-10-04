import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { PresupuestoService } from '../../../servicios/contabilidad/presupuesto.service';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { CommonModule, Location } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FilterPipe } from '../../../pipes/filter.pipe';

@Component({
  selector: 'app-info-proyecto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, FilterPipe, RouterLink],
  templateUrl: './info-proyecto.component.html',
  styleUrl: './info-proyecto.component.css',
})
export class InfoProyectoComponent implements OnInit {
  title: string = 'Detalles proyecto';
  stringFilter!: string;
  _pgastos?: any;
  _gProyectos?: any;
  _codigo!: string;
  constructor(
    private serverConfigService: ServerConfigService,
    private _params: ActivatedRoute,
    private proyectosService: ProyectosService,
    private presupuestoService: PresupuestoService,
    private location: Location
  ) {}
  ngOnInit(): void {
    const codigoParam = this._params.snapshot.paramMap.get('codigo');
    if (codigoParam) {
      this._codigo = codigoParam;
      this.getGProyectos(codigoParam);
      this.title += ` ${codigoParam}`;
    } else {
      console.warn('No se encontró el parámetro "codigo" en la ruta.');
      this.swal('error', 'No se encontró el parámetro "codigo" en la ruta.');
    }
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue;
    });
  }
  volver(): void {
    this.location.back();
  }

  getGProyectos(codigo: string) {
    this.proyectosService.getByCodigoLike(codigo).subscribe({
      next: (proyectos: any) => {
        if (proyectos.body) {
          this._gProyectos = proyectos.body;
          this.swal(proyectos.status, proyectos.message);
        } else {
          this.swal('warning', 'Proyecto sin datos ingresados');
        }
      },
      error: (e: any) => {
        console.error(e);
      },
    });
  }
  getPartidasGastos(codigo: string) {
    this.presupuestoService.getByCodigoProyectoLike(codigo).subscribe({
      next: (datos: any) => {
        if (datos.body) {
          this._pgastos = datos.body;
          this.swal(datos.status, datos.message);
        } else {
          this.swal('warning', 'Proyecto no tiene partidas presupuestarias');
        }
      },
      error: (e: any) => console.error(e),
    });
  }
  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
    });
  }
}

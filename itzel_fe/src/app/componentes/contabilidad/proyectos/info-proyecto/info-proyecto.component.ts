import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ServerConfigService } from '../../../../servicios/config/server-config.service';
import { FilterPipe } from '../../../../pipes/filter.pipe';
import { ActivatedRoute } from '@angular/router';
import Swal from 'sweetalert2';
import { ProyectosService } from '../../../../servicios/contabilidad/proyectos.service';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';

@Component({
  selector: 'app-info-proyecto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, FilterPipe],
  templateUrl: './info-proyecto.component.html',
  styleUrl: './info-proyecto.component.css',
})
export class InfoProyectoComponent implements OnInit {
  title: string = 'Información de proyecto';
  stringFilter!: string;
  _pgastos?: any;
  _codigo!: string;
  constructor(
    private serverConfigService: ServerConfigService,
    private _params: ActivatedRoute,
    private proyectoService: ProyectosService,
    private presupuestoService: PresupuestoService
  ) {}
  ngOnInit(): void {
    const codigoParam = this._params.snapshot.paramMap.get('codigo');
    if (codigoParam) {
      console.log(codigoParam);
      this._codigo = codigoParam;
    } else {
      console.warn('No se encontró el parámetro "codigo" en la ruta.');
      this.swal('error', 'No se encontró el parámetro "codigo" en la ruta.');
    }
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue;
    });
  }
  getProyectos(codigo: string) {
    this.proyectoService.getByCodigoLike(codigo).subscribe({
      next: (_proyectos: any) => {
        console.log(_proyectos);
      },
      error: (e: any) => {
        console.error(e);
      },
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

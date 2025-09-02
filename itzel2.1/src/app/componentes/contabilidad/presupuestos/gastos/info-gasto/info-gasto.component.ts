import { Component } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import Swal from 'sweetalert2';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import { ServerConfigService } from '../../../../servicios/config/server-config.service';
import { CommonModule, Location } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-info-gasto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, RouterLink],
  templateUrl: './info-gasto.component.html',
  styleUrl: './info-gasto.component.css',
})
export class InfoGastoComponent {
  title: string = 'Detalles partida gasto ';
  stringFilter!: string;
  _pgasto: any = {
    nompar: '',
    codigo: '',
    codpar: '',
    idproyecto: {},
    idclasificador: {},
    inicia: 0,
    totcerti: 0,
    totdeven: 0,
    totmod: 0,
    feccrea: null,
  };
  _idpartida?: number;

  constructor(
    private _params: ActivatedRoute,
    private serverConfigService: ServerConfigService,
    private presupuestoService: PresupuestoService,
    private location: Location
  ) {}
  ngOnInit(): void {
    const codigoParam = this._params.snapshot.paramMap.get('idpresupuesto');
    if (codigoParam) {
      this._idpartida = +codigoParam!;
      this.getPresupuestoById(this._idpartida);
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

  getPresupuestoById(idpresupuesto: number) {
    this.presupuestoService.findById(idpresupuesto).subscribe({
      next: (presupuesto: any) => {
        console.log(presupuesto);
        this._pgasto = presupuesto;
      },
      error: (e: any) => {
        console.error(e);
        this.swal('error', 'Error al obtener presupuesto');
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

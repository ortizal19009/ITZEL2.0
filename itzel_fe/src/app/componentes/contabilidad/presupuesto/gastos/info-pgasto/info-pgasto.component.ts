import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FilterPipe } from '../../../../../pipes/filter.pipe';
import { ActivatedRoute } from '@angular/router';
import Swal from 'sweetalert2';
import { ServerConfigService } from '../../../../../servicios/config/server-config.service';

@Component({
  selector: 'app-info-pgasto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, FilterPipe],
  templateUrl: './info-pgasto.component.html',
  styleUrl: './info-pgasto.component.css',
})
export class InfoPgastoComponent {
  title: string = 'Detalles partida gasto';
  stringFilter!: string;

  _idpartida?: number;

  constructor(
    private _params: ActivatedRoute,
    private serverConfigService: ServerConfigService
  ) {}
  ngOnInit(): void {
    const codigoParam = this._params.snapshot.paramMap.get('idpresupuesto');
    if (codigoParam) {
      this._idpartida = +codigoParam!;
      this.title += ` ${codigoParam}`;
    } else {
      console.warn('No se encontró el parámetro "codigo" en la ruta.');
      this.swal('error', 'No se encontró el parámetro "codigo" en la ruta.');
    }
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue;
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

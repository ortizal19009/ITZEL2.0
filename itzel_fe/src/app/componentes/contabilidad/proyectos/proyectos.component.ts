import { CommonModule } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { FilterPipe } from '../../../pipes/filter.pipe';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-proyectos',
  imports: [CommonModule, RouterLink, FormsModule, FilterPipe],
  templateUrl: './proyectos.component.html',
  styleUrl: './proyectos.component.css',
})
export class ProyectosComponent implements OnInit {
  title?: string = 'Proyectos';
  _proyectos?: any;
  stringFilter!: string;
  options: any = {};
  messageRecived: string = '';
  swAddProject: Boolean = true;
  constructor(
    private proyectosService: ProyectosService,
    private serverConfigService: ServerConfigService
  ) {}
  ngOnInit(): void {
    this.getAllProyectos();
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue;
    });
  }
  getAllProyectos() {
    this.proyectosService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {
        this._proyectos = proyectos;
      },
    });
  }
  receiveMessageAddProyect(message: string) {
    if (message === 'success') {
      this.swal('success', 'Datos guardados conexito');
      this.getAllProyectos();
    } else {
      alert('Datos no guardados');
      this.swal('error', 'No guardado');
    }
  }
  delete(idproyecto: any) {
    this.proyectosService.proyectoDelete(idproyecto).subscribe({
      next: (datos: any) => {
        this.swal(datos.status, datos.message);
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

import { CommonModule } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { FilterPipe } from '../../../pipes/filter.pipe';
import Swal from 'sweetalert2';
import { Proyectos } from '../../../modelos/contabilidad/proyectos';

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
  _proyecto: Proyectos = new Proyectos();
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
  setDataToDelete(proyecto: any) {
    this._proyecto = proyecto;
  }
  delete() {
    this.proyectosService.proyectoDelete(this._proyecto.idproyecto!).subscribe({
      next: (datos: any) => {
        this.swal(datos.status, datos.message);
        this.getAllProyectos();
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

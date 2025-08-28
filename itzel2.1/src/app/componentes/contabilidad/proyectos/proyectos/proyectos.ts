import { Component } from '@angular/core';
import Swal from 'sweetalert2';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { Proyecto } from '../../../modelos/contabilidad/proyecto.model';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';

@Component({
  selector: 'app-proyectos',
  imports: [],
  templateUrl: './proyectos.html',
  styleUrl: './proyectos.css'
})
export class Proyectos {
  title?: string = 'Proyectos';
  _proyectos?: any;
  stringFilter!: string;
  options: any = {};
  messageRecived: string = '';
  swAddProject: Boolean = true;
  _proyecto: Proyecto = new Proyecto();
  constructor(
    private proyectosService: ProyectoService,
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

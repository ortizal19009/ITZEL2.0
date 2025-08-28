import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { Proyecto } from '../../../modelos/contabilidad/proyecto.model';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { FilterPipe } from '../../../pipes/filter.pipe';

@Component({
  selector: 'app-proyectos',
  imports: [RouterLink, CommonModule, FilterPipe],
  templateUrl: './proyectos.html',
  styleUrl: './proyectos.css',
})
export class Proyectos implements OnInit {
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
    this.swalConfirm();
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
  swalConfirm() {
    Swal.fire({
      title: 'Deseas eliminar el registro?',
      //showDenyButton: true,
      showCancelButton: true,
      confirmButtonText: 'Aceptar',
/*       denyButtonText: `Don't save`, */
    }).then((result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        this.delete();
      } else if (result.isDenied) {
        this.swal('Info!', 'Datos no han sidio guardados');
      }
    });
  }
}

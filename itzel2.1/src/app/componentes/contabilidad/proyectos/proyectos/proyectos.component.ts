import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { Proyecto } from '../../../modelos/contabilidad/proyecto.model';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';

@Component({
  selector: 'app-proyectos',
  standalone: true,
  imports: [RouterLink, CommonModule],
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
  _proyecto: Proyecto = new Proyecto();
  cargosFiltrados: Proyecto[] = [];
  ordenColumna: keyof ProyectoVisual = 'codigo';
  ordenAscendente: boolean = true;

  constructor(
    private proyectosService: ProyectoService,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private elimService: EliminadosService
  ) {}
  ngOnInit(): void {
    console.log(this.authService.idusuario);
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }

    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/proyectos');
      let coloresJSON = sessionStorage.getItem('/proyectos');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.getAllProyectos();
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'proyectos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/proyectos', coloresJSON);
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

  getAllProyectos() {
    this.proyectosService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {
        this.cargosFiltrados = proyectos;
      },
      error: (err: any) => {
        console.error(err.error);
        this.swal('error', err.error);
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
  cerrar() {
    this.router.navigate(['/inicio']);
  }
  ordenarPor(campo: keyof ProyectoVisual): void {
    console.log(campo);
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.cargosFiltrados.sort((a: any, b: any) => {
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
      /*    denyButtonText: `Don't save`, */
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
interface ProyectoVisual {
  codigo: string;
  nombre: string;
}

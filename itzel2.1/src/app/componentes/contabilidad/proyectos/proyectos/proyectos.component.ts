import { Component, OnInit } from '@angular/core';
import Swal from 'sweetalert2';
import { Proyecto } from '../../../modelos/contabilidad/proyecto.model';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { Estructura } from '../../../modelos/contabilidad/estructura.model';
import { FormsModule } from '@angular/forms';
import { DefinirService } from '../../../servicios/administracion/definir.service';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

@Component({
  selector: 'app-proyectos',
  standalone: true,
  imports: [RouterLink, CommonModule, FormsModule],
  templateUrl: './proyectos.component.html',
  styleUrl: './proyectos.component.css',
})
export class ProyectosComponent implements OnInit {
  title?: string = 'Proyectos';
  proyectos: any[] = [];
  stringFilter!: string;
  options: any = {};
  messageRecived: string = '';
  swAddProject: Boolean = true;
  _proyecto: Proyecto = new Proyecto();
  proyectosFiltrados: Proyecto[] = [];
  ordenColumna: keyof ProyectoVisual = 'codigo';
  ordenAscendente: boolean = true;
  estructura: Estructura[] = [];
  saludo!: SafeHtml;
  constructor(
    private proyectosService: ProyectoService,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private elimService: EliminadosService,
    private definir: DefinirService,
    private sanitizer: DomSanitizer
  ) {}
  ngOnInit(): void {
    /*     if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    } */
this.definir.getByIddefinir(1).subscribe({
      next: (datos: any) => {
        console.log(datos);
        this.saludo = this.sanitizer.bypassSecurityTrustHtml(datos.html);
      },
      error: (e: any) => {
        console.error(e.error);
      },
    });
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
        this.proyectos = proyectos; // guardo todos los proyectos
        this.proyectosFiltrados = [...proyectos]; // inicializo lista filtrada
      },
      error: (err: any) => {
        console.error(err.error);
        this.swal('error', err.error);
      },
    });
  }

  filtrar() {
    if (!this.stringFilter) {
      this.proyectosFiltrados = [...this.proyectos]; // si está vacío, muestro todos
      return;
    }

    const filter = this.stringFilter.toLowerCase();
    this.proyectosFiltrados = this.proyectos.filter(
      (proyecto) =>
        proyecto.nombre?.toLowerCase().includes(filter) || // ejemplo campo nombre
        proyecto.codigo?.toLowerCase().includes(filter) // ejemplo campo código
    );
  }
  setEstructura(estructura: any) {
    return estructura.nivel;
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
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.proyectosFiltrados.sort((a: any, b: any) => {
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

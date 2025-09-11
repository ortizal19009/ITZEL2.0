import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { EstructuraService } from '../../../servicios/contabilidad/estructura.service';
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
import { Estructura } from '../../../modelos/contabilidad/estructura.model';
import Swal from 'sweetalert2';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';

@Component({
  selector: 'app-modi-proyecto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './modi-proyecto.component.html',
  styleUrl: './modi-proyecto.component.css',
})
export class ModiProyectoComponent implements OnInit {
  title: string = 'Modificar proyecto';
  _estructuras: any;
  f_proyecto!: FormGroup;
  sw_codigo: boolean = false;
  sw_nombre: boolean = false;
  idproyecto?: number;
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectoService: ProyectoService,
    private _params: ActivatedRoute,
    public authService: AutorizaService,
    private coloresService: ColoresService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/modi-proyecto');
      let coloresJSON = sessionStorage.getItem('/modi-proyecto');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.idproyecto = +this._params.snapshot.paramMap.get('idproyecto')!;
    this.f_proyecto = this.fb.group({
      idproyecto: '',
      codigo: ['', Validators.min(2)],
      nombre: ['', Validators.required],
      movimiento: [false, Validators.required],
      estructura: '',
    });
    this.getAllEstructuras();
    this.getByIdProyecto(this.idproyecto);
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'modi-proyecto');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/modi-proyecto', coloresJSON);
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
  getAllEstructuras() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (estructuras: any) => {
        console.table(estructuras);
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          estructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  regresar() {
    this.router.navigate(['/proyectos']);
  }
  getByIdProyecto(idproyecto: number) {
    this.proyectoService.proyectoGetById(idproyecto).subscribe({
      next: (_proyecto: any) => {
        this.f_proyecto.patchValue({
          idproyecto: _proyecto.idproyecto,
          codigo: _proyecto.codigo,
          nombre: _proyecto.nombre,
          movimiento: _proyecto.movimiento,
          estructura: _proyecto.estructura,
        });
      },
      error: (e: any) => console.error(e),
    });
  }

  get f() {
    return this.f_proyecto.controls;
  }

  getValidacionCodigo(codigo: any) {
    const code = codigo.target.value;
    const estructura: any = this.f_proyecto.value;
    const codigoControl = this.f_proyecto.get('codigo');
    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        const longitudEsperada = estructura.estructura.longitud * estructura.estructura.nivel;
        const longitudInvalida = code.length !== longitudEsperada;
        const codigoDuplicado = validador;
        const codigoNoValido = codigoDuplicado || longitudInvalida;
        this.sw_codigo = codigoNoValido;
        if (codigoDuplicado) {
          this.swal('error', 'El código ya existe');
        }
        if (longitudInvalida) {
          this.swal('error', 'Error en la longitud del codigo ');
        }
        if (codigoNoValido) {
          codigoControl?.setErrors({ codigoNoValido: true });
        } else {
          codigoControl?.setErrors(null);
        }
        codigoControl?.markAsTouched();
      },
      error: (e: any) => console.error(e),
    });
  }

  getValidarNombre(nombre: any) {
    const name = nombre.target.value;
    const nameControl = this.f_proyecto.get('nombre');
    this.proyectoService.validarNombre(name).subscribe({
      next: (validador: any) => {
        this.sw_nombre = validador;

        if (validador) {
          // Poner error personalizado cuando el nombre es inválido
          this.swal(
            'error',
            'Nombre no valido <br> Nombre ya existe o no cumple con el formato necesario'
          );
          nameControl?.setErrors({ nombreNoValido: true });
        } else {
          // Quitar errores si es válido
          nameControl?.setErrors(null);
        }
      },
      error: (e: any) => console.error(e),
    });
  }

  save() {
    this.proyectoService.proyectosUpdate(this.f_proyecto.value).subscribe({
      next: (request: any) => {
        this.swal(request.status, request.message);
        setTimeout(() => {}, 3000);
        if (request.status === 'success') {
          this.router.navigate(['/proyectos']);
        }
      },
      error: (e: any) => console.error(e),
    });
  }

  compararEstructura(o1: Estructura, o2: Estructura): boolean {
    if (o1 === undefined && o2 === undefined) {
      return true;
    } else {
      return o1 === null || o2 === null || o1 === undefined || o2 === undefined
        ? false
        : o1.idestructura == o2.idestructura;
    }
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

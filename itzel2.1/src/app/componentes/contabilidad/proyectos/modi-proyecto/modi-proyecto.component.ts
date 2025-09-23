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
import { Proyecto } from '../../../modelos/contabilidad/proyecto.model';

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
  maxLongitud!: number;
  _proyecto: Proyecto = new Proyecto();
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
      const datos = await this.coloresService.setcolor(
        this.authService.idusuario!,
        'modi-proyecto'
      );
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
        this._proyecto = _proyecto;
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
    let code = codigo.target.value;
    const cleanCode = code.replace(/[^a-zA-Z0-9]/g, '');
    const codigoControl = this.f_proyecto.get('codigo');

    // Movimiento según longitud
    if (code.length === this.maxLongitud) {
      this.f_proyecto.patchValue({ movimiento: true });
    } else {
      this.f_proyecto.patchValue({ movimiento: false });
    }

    // Buscar estructura
    const estructuraEncontrada = this._estructuras.find(
      (e: any) => cleanCode.length === e.sumlongitud
    );
    this.f_proyecto.patchValue({ estructura: estructuraEncontrada });

    // Validación inicial de estructura
    if (!estructuraEncontrada) {
      codigoControl?.setErrors({ ...(codigoControl?.errors || {}), codigoNoValido: true });
    }

    // Validación en backend
    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        let f = this.f_proyecto.value;
        let message: string | null = null;
        const longitudInvalida =
          estructuraEncontrada && cleanCode.length !== estructuraEncontrada.sumlongitud;
        if (validador) {
          if (f.codigo === this._proyecto.codigo) {
            validador = false;
          }
        }
        const codigoDuplicado = validador;
        const codigoNoValido = codigoDuplicado || longitudInvalida;

        const currentErrors = codigoControl?.errors || {};

        if (codigoNoValido) {
          if (codigoDuplicado) {
            message = 'El código ya existe';
          }
          if (longitudInvalida) {
            message = 'Longitud inválida';
          }

          codigoControl?.setErrors({
            ...currentErrors,
            customError: message,
          });
        } else {
          // Si no hay error de backend, quitar solo customError
          if (currentErrors['customError']) {
            delete currentErrors['customError'];
            codigoControl?.setErrors(Object.keys(currentErrors).length > 0 ? currentErrors : null);
          }
        }

        codigoControl?.markAsTouched();
      },
      error: (e: any) => console.error(e),
    });
  }

  getCodigoErrors(): string[] {
    const errors = this.f['codigo'].errors;
    if (!errors) return [];

    const mensajes: string[] = [];

    if (errors['required']) {
      mensajes.push('Valor obligatorio');
    }
    if (errors['minlength']) {
      mensajes.push('El valor debe tener más de 1 caracter');
    }
    if (errors['customError']) {
      mensajes.push(errors['customError']);
    }
    if (errors['codigoNoValido']) {
      mensajes.push('La estructura del código no es válida');
    }

    // Eliminar duplicados usando Set
    return [...new Set(mensajes)];
  }

  getValidarNombre(nombre: any) {
    const name = nombre.target.value.trim();
    const nameControl = this.f_proyecto.get('nombre');

    // Llamada al backend
    this.proyectoService.validarNombre(name).subscribe({
      next: (validador: any) => {
        this.sw_nombre = validador;

        // Recuperamos errores actuales (ej: required, minlength)
        const currentErrors = nameControl?.errors || {};

        if (validador) {
          // Nombre inválido por duplicado o formato
          nameControl?.setErrors({
            ...currentErrors,
            nombreNoValido: 'El nombre ya existe o no cumple el formato',
          });

          this.swal(
            'error',
            'Nombre no válido <br> Nombre ya existe o no cumple con el formato necesario'
          );
        } else {
          // Si estaba marcado el error nombreNoValido lo quitamos
          if (currentErrors['nombreNoValido']) {
            delete currentErrors['nombreNoValido'];
            // Reasignamos los errores restantes (si existen) o null
            if (Object.keys(currentErrors).length > 0) {
              nameControl?.setErrors(currentErrors);
            } else {
              nameControl?.setErrors(null);
            }
          }
        }

        nameControl?.markAsTouched();
      },
      error: (e: any) => console.error(e),
    });
  }
  getNombreErrors(): string[] {
    const errors = this.f['nombre'].errors;
    if (!errors) return [];

    const mensajes: string[] = [];

    if (errors['required']) {
      mensajes.push('El nombre es obligatorio');
    }
    if (errors['minlength']) {
      mensajes.push('El nombre es demasiado corto');
    }
    if (errors['nombreNoValido']) {
      mensajes.push(errors['nombreNoValido']);
    }

    // Eliminar duplicados
    return [...new Set(mensajes)];
  }

  save() {
    this.proyectoService.proyectosUpdate(this.f_proyecto.value).subscribe({
      next: (request: any) => {
        this.swal('success', 'Datos actualizados');
        this.router.navigate(['/proyectos']);
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

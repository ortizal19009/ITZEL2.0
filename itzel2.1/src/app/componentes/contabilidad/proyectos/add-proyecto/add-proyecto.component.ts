import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import Swal from 'sweetalert2';
import { EstructuraService } from '../../../servicios/contabilidad/estructura.service';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'app-add-proyecto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './add-proyecto.component.html',
  styleUrl: './add-proyecto.component.css',
})
export class AddProyectoComponent implements OnInit {
  title: string = 'Crear nuevo proyecto';
  _estructuras: any;
  f_proyecto!: FormGroup;
  sw_codigo: boolean = false;
  sw_nombre: boolean = false;
  _request!: any;
  date: Date = new Date();
  maxLongitud!: number;
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectosService: ProyectosService,
    public authService: AutorizaService,
    private coloresService: ColoresService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }

    this.f_proyecto = this.fb.group({
      codigo: ['', [Validators.minLength(2), Validators.required]], // ojo: minLength, no min (min es para números)
      nombre: ['', [Validators.required]],
      movimiento: [false, [Validators.required]],
      estructura: [''],
      usucrea: [1],
      feccrea: [this.date],
    });
    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/add-proyecto');
      let coloresJSON = sessionStorage.getItem('/add-proyecto');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.getAllProyectos();
    this.getAllEsctructuras();
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'proyectos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/add-proyecto', coloresJSON);
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
  get f() {
    return this.f_proyecto.controls;
  }

  validateForm() {
    if (this.f_proyecto.invalid) {
      Object.keys(this.f_proyecto.controls).forEach((field) => {
        const control = this.f_proyecto.get(field);
        if (control && control.invalid) {
          if (control.errors?.['required']) {
            this.swal('error', `El campo ${field} es obligatorio`);
          }
          if (control.errors?.['minlength']) {
            this.swal(
              'error',
              `El campo ${field} debe tener mínimo ${control.errors['minlength'].requiredLength} caracteres`
            );
          }
          if (control.errors?.['maxlength']) {
            this.swal(
              'error',
              `El campo ${field} debe tener máximo ${control.errors['maxlength'].requiredLength} caracteres`
            );
          }
        }
      });
      return false;
    }
    return true;
  }

  getAllProyectos() {
    this.proyectosService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {},
      error: (e: any) => console.error(e),
    });
  }
  regresar() {
    this.router.navigate(['/proyectos']);
  }
  getAllEsctructuras() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (estructuras: any) => {
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          estructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
    this.estructuraService.findTopByOrderByNivelDesc().subscribe({
      next: (estructura: any) => {
        this.maxLongitud = estructura.sumlongitud;
      },
      error: (e: any) => console.error(e.error),
    });
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
    this.proyectosService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        let message: string | null = null;
        const longitudInvalida =
          estructuraEncontrada && cleanCode.length !== estructuraEncontrada.sumlongitud;
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
    this.proyectosService.validarNombre(name).subscribe({
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
    this.proyectosService.proyectoSave(this.f_proyecto.value).subscribe({
      next: (request: any) => {
        this._request = request.message;
        this.swal(request.status, request.message);
        this.router.navigate(['/proyectos']);
      },
      error: (e: any) => {
        console.error(e);
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

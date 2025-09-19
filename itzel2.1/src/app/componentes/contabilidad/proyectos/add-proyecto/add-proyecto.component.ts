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
import { ProyectoService } from '../../../servicios/contabilidad/proyecto.service';
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
    private proyectoService: ProyectoService,
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

  showControlError(field: string) {
    const control = this.f_proyecto.get(field);
    console.log(field);
    if (control && control.invalid && (control.dirty || control.touched)) {
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
  }

  getAllProyectos() {
    this.proyectoService.proyectosGetAll().subscribe({
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
        console.log(estructuras);
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          estructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
    this.estructuraService.findTopByOrderByNivelDesc().subscribe({
      next: (estructura: any) => {
        console.log(estructura);
        this.maxLongitud = estructura.sumlongitud;
      },
      error: (e: any) => console.error(e.error),
    });
  }
  getValidacionCodigo(codigo: any) {
    let code = codigo.target.value;
    console.log(code.length);
    const cleanCode = code.replace(/[^a-zA-Z0-9]/g, '');
    const codigoControl = this.f_proyecto.get('codigo');

    console.log(this.maxLongitud);
    if (code.length === this.maxLongitud) {
      this.f_proyecto.patchValue({
        movimiento: true,
      });
    } else {
      this.f_proyecto.patchValue({
        movimiento: false,
      });
    }
    let _estructuras = this._estructuras;
    const estructuraEncontrada = _estructuras.find((e: any) => cleanCode.length === e.sumlongitud);
    this.f_proyecto.patchValue({
      estructura: estructuraEncontrada,
    });
    if (!estructuraEncontrada) {
      codigoControl?.setErrors({ codigoNoValido: true });
    } else {
      codigoControl?.setErrors(null);
    }

    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        console.log(validador);
        const longitudInvalida = cleanCode.length !== estructuraEncontrada.sumlongitud;
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
    this.proyectoService.proyectoSave(this.f_proyecto.value).subscribe({
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

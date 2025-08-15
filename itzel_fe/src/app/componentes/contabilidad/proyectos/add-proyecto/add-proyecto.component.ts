import { CommonModule } from '@angular/common';
import { Component, EventEmitter, OnInit, Output, output } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { EstructuraService } from '../../../../servicios/contabilidad/estructura.service';
import { ProyectosService } from '../../../../servicios/contabilidad/proyectos.service';
import Swal from 'sweetalert2';

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
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectoService: ProyectosService
  ) {}
  ngOnInit(): void {
    this.f_proyecto = this.fb.group({
      codigo: ['', [Validators.minLength(2), Validators.required]], // ojo: minLength, no min (min es para números)
      nombre: ['', [Validators.required]],
      movimiento: [false, [Validators.required]],
      idestructura: [''],
      usucrea: [1],
      feccrea: [this.date],
    });

    this.getAllProyectos();
    this.getAllEsctructuras();
  }
  get f() {
    return this.f_proyecto.controls;
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
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          idestructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  getValidacionCodigo(codigo: any) {
    const code = codigo.target.value;
    const estructura: any = this.f_proyecto.value;
    const codigoControl = this.f_proyecto.get('codigo');

    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        const longitudEsperada =
          estructura.idestructura.longitud * estructura.idestructura.nivel;
        const longitudInvalida = code.length !== longitudEsperada;
        const codigoDuplicado = validador;
        const codigoNoValido = codigoDuplicado || longitudInvalida;
        this.sw_codigo = codigoNoValido;
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

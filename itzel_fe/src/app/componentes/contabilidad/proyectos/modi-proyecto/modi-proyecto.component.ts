import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { EstructuraService } from '../../../../servicios/contabilidad/estructura.service';
import { ProyectosService } from '../../../../servicios/contabilidad/proyectos.service';
import { Estructura } from '../../../../modelos/contabilidad/estructura';
import Swal from 'sweetalert2';

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
    private proyectoService: ProyectosService,
    private _params: ActivatedRoute
  ) {}
  ngOnInit(): void {
    this.idproyecto = +this._params.snapshot.paramMap.get('idproyecto')!;
    this.f_proyecto = this.fb.group({
      idproyecto: '',
      codigo: ['', Validators.min(2)],
      nombre: ['', Validators.required],
      movimiento: [false, Validators.required],
      idestructura: '',
    });
    this.getAllEstructuras();
    this.getByIdProyecto(this.idproyecto);
  }
  getAllEstructuras() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (estructuras: any) => {
        console.table(estructuras);
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          idestructura: estructuras[0],
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
          idestructura: _proyecto.idestructura,
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
  get f() {
    return this.f_proyecto.controls;
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
    this.proyectoService.proyectosUpdate(this.f_proyecto.value).subscribe({
      next: (request: any) => {
        console.log(request);
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

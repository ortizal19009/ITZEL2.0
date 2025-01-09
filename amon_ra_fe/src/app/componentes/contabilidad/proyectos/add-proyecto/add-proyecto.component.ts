import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ProyectosService } from '../../../../servicioss/contabilidad/proyectos.service';
import { EstructuraService } from '../../../../servicioss/contabilidad/estructura.service';
import { Router } from '@angular/router';

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
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private proyectoService: ProyectosService
  ) {}
  ngOnInit(): void {
    this.f_proyecto = this.fb.group({
      codigo: ['', Validators.min(2)],
      nombre: ['', Validators.required],
      movimiento: [false, Validators.required],
      idestructura_estructura: '',
    });
    this.getAllProyectos();
  }
  getAllProyectos() {
    this.proyectoService.proyectosGetAll().subscribe({
      next: (estructuras: any) => {
        console.table(estructuras);
        this._estructuras = estructuras;
        this.f_proyecto.patchValue({
          idestructura_estructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  regresar() {
    this.router.navigate(['/proyectos']);
  }
  getValidacionCodigo(codigo: any) {
  let code = codigo.target.value;
    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        if (codigo.length % 2 == 0) {
          this.sw_codigo = validador;
        } else {
          this.sw_codigo = true;
        }
      },
      error: (e: any) => console.error(e),
    });
  }
  getValidarNombre(nombre: any) {
  let name = nombre.target.value; 
    this.proyectoService.validarNombre(name).subscribe({
      next: (validador: any) => {
        console.log(validador);
        this.sw_nombre = validador;
      },
      error: (e: any) => console.error(e),
    });
  }
  save() {
    //console.log(this.f_proyecto.value);
    this.proyectoService.proyectoSave(this.f_proyecto.value).subscribe({
      next: (request: any) => {
        console.log(request);
        this._request = request.message;
        setTimeout(() => {
          this._request = '';
        }, 3000);
        if (request.status === 'success') {
          this.router.navigate(['/proyectos']);
        }
      },
      error: (e: any) => console.error(e),
    });
  }
}

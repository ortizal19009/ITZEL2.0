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
  @Output() messageEvent = new EventEmitter<string>();
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
      idestructura: '',
      usucrea: 1,
      feccrea: this.date,
    });
    this.getAllProyectos();
    this.getAllEsctructuras();
  }
  getAllProyectos() {
    this.proyectoService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {
        console.log(proyectos);
      },
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
    let code = codigo.target.value;
    console.log(code);
    this.proyectoService.validarCodigo(code).subscribe({
      next: (validador: any) => {
        console.log(validador);
        if (code.length % 2 == 0) {
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
          this.messageEvent.emit(request.status);

      },
      error: (e: any) => {
        console.error(e);
        this.messageEvent.emit("error");
      },
    });
  }
}

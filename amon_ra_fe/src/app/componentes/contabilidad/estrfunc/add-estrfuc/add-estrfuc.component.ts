import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { EstructuraService } from '../../../../servicioss/contabilidad/estructura.service';
import { EstrfuncService } from '../../../../servicioss/contabilidad/estrfunc.service';
import { min, timeout } from 'rxjs';

@Component({
  selector: 'app-add-estrfuc',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './add-estrfuc.component.html',
  styleUrl: './add-estrfuc.component.css',
})
export class AddEstrfucComponent implements OnInit {
  title: string = 'Crear nueva funcion estructura';
  _estructuras: any;
  f_estrfunc!: FormGroup;
  sw_codigo: boolean = false;
  sw_nombre: boolean = false;
  _request!: any;

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private estrfuncService: EstrfuncService
  ) {}
  ngOnInit(): void {
    this.f_estrfunc = this.fb.group({
      codigo: ['', Validators.min(2)],
      nombre: ['', Validators.required],
      movimiento: [false, Validators.required],
      idestructura_estructura: '',
    });
    this.estructuraGetAll();
  }
  estructuraGetAll() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (estructuras: any) => {
        console.table(estructuras);
        this._estructuras = estructuras;
        this.f_estrfunc.patchValue({
          idestructura_estructura: estructuras[0],
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  regresar() {
    this.router.navigate(['/estrfunc']);
  }
  validarCodigo(e: any) {
    let codigo = e.target.value;
    this.getValidacionCodigo(codigo);
  }
  getValidacionCodigo(codigo: string) {
    this.estrfuncService.validarCodigo(codigo).subscribe({
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
  validarNombre(e: any) {
    console.log(e.target.value);
    let nombre: string = e.target.value;
    this.validarNombre(nombre);
  }
  getValidarNombre(nombre: string) {
    this.estrfuncService.validarNombre(nombre).subscribe({
      next: (validador: any) => {
        console.log(validador);
        this.sw_nombre = validador;
      },
      error: (e: any) => console.error(e),
    });
  }
  save() {
    //console.log(this.f_estrfunc.value);
    this.estrfuncService.estrfuncSave(this.f_estrfunc.value).subscribe({
      next: (request: any) => {
        console.log(request);
        this._request = request.message;
        setTimeout(() => {
          this._request = '';
        }, 3000);
        if (request.status === 'success') {
          this.router.navigate(['/estrfunc']);
        }
      },
      error: (e: any) => console.error(e),
    });
  }
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ClasificadorService } from '../../../servicios/contabilidad/clasificador.service';
import { map, of } from 'rxjs';

@Component({
  selector: 'app-add-clasificador.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './add-clasificador.component.html',
  styleUrl: './add-clasificador.component.css'
})
export class AddClasificadorComponent implements OnInit {

  formClasificador!: FormGroup;
  codgrupo!: string;

  constructor(public fb: FormBuilder, public router: Router, public authService: AutorizaService,
    private clasifService: ClasificadorService) { }

  ngOnInit(): void {
    if (!this.authService.sessionlog) { this.router.navigate(['/inicio']); }
    sessionStorage.setItem('ventana', '/clasificador');
    let coloresJSON = sessionStorage.getItem('/clasificador');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    let date: Date = new Date();
    this.formClasificador = this.fb.group({
      codpar: ['', [Validators.required], [this.valFormato.bind(this), this.valGrupo.bind(this), this.valCodpar.bind(this)]],
      nivpar: 0,
      grupar: [''],
      nompar: ['', [Validators.required, Validators.minLength(3)]],
      despar: [''],
      cueejepresu: [''],
      presupuesto: 0,
      ejecucion: 0,
      devengado: 0,
      reforma: 0,
      asigna_ini: 0,
      usucrea: 1,
      feccrea: date,
      balancostos: 0
    },
      { updateOn: "blur" });
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1')
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  regresar() { this.router.navigate(['/clasificador']); }

  get f() { return this.formClasificador.controls; }

  guardar(): void {
    //Coloca nivpar y grupar
    const codpar = this.formClasificador.value.codpar;
    const l = codpar.length;
    switch (this.formClasificador.value.codpar.length) {
      case 1: this.formClasificador.value.nivpar = 1; this.formClasificador.value.grupar = 1; break;
      case 2: this.formClasificador.value.nivpar = 2; this.formClasificador.value.grupar = codpar.slice(0, 1); break;
      case 5: this.formClasificador.value.nivpar = 3; this.formClasificador.value.grupar = codpar.slice(0, 3); break;
      case 8: this.formClasificador.value.nivpar = 4; this.formClasificador.value.grupar = codpar.slice(0, 5); break;
    }
    this.clasifService.save(this.formClasificador.value).subscribe({
      next: () => this.router.navigate(['/clasificador']),
      error: err => {
        console.error('Al guardar en Clasificador: ', err.error);
        this.authService.mostrarError('Error al guardar', err.error);
      }
    });
  }

  //Valida el formato de codpar
  valFormato(control: AbstractControl) {
    let rtn = this.validateFormato(control.value);
    if (!rtn) return of({ invalido: true });
    else return of(null);
  }

  // Expresión regular para validar formato 
  validateFormato(str: string): boolean {
    const regex = /^(?:\d{1,2}|\d{2}\.\d{2}|\d{2}\.\d{2}\.\d{2})$/;
    return regex.test(str);
  }

  //Valida grupo
  valGrupo(control: AbstractControl) {
    let g: number;
    switch (control.value.length) {
      case 1: return of(null);
      case 2: g = 1; break;
      case 5: g = 2; break;
      case 8: g = 5; break;
      default: return of(null);
    }
    this.codgrupo = control.value.slice(0, g);
    return this.clasifService.valCodpar(this.codgrupo).pipe(
      map(result => !result ? { grupoinvalido: true } : null)
    );
  }

  //Valida codpar
  valCodpar(control: AbstractControl) {
    return this.clasifService.valCodpar(control.value).pipe(
      map(result => result ? { existe: true } : null)
    );
  }

}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';

import {
  FormBuilder,
  FormGroup,
  FormsModule,
  MinLengthValidator,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { FilterPipe } from '../../../../../pipes/filter.pipe';
import { ClasificadorService } from '../../../../../servicios/contabilidad/clasificador.service';
import { Proyectos } from '../../../../../modelos/contabilidad/proyectos';
import { PresupuestoService } from '../../../../../servicios/contabilidad/presupuesto.service';
import { Presupuesto } from '../../../../../modelos/contabilidad/presupuesto';
@Component({
  selector: 'app-add-pingreso',
  imports: [CommonModule, FormsModule, RouterLink, ReactiveFormsModule],
  templateUrl: './add-pingreso.component.html',
  styleUrl: './add-pingreso.component.css',
})
export class AddPingresoComponent implements OnInit {
  title: string = 'Nuevo presupuesto de ingreso';
  modalTitle: string = 'Buscar clasificador';
  f_pingreso!: FormGroup;
  f_clasificador!: FormGroup;
  _clasificador: any;
  _request?: string;
  modalFiltrar: string = ''; // Inicializa la propiedad
  date: Date = new Date();
  constructor(
    private fb: FormBuilder,
    private s_clasificador: ClasificadorService,
    private s_presupuesto: PresupuestoService
  ) {}
  ngOnInit(): void {
    this.f_pingreso = this.fb.group({
      tippar: 1,
      codpar: ['', Validators.minLength(14)],
      codigo: '',
      nompar: ['', Validators.minLength(4)],
      inicia: [0.0, Validators.required],
      idproyecto: '',
      idclasificador: '',
      clasi_codpar: '',
      clasi_nompar: '',
    });
    this.f_clasificador = this.fb.group({
      codnompar: '',
    });
    let proyecto: Proyectos = new Proyectos();
    proyecto.idproyecto = 1;
    this.f_pingreso.patchValue({
      idproyecto: proyecto,
    });
    // Suscríbete a los cambios en el control 'codparti'
    this.f_pingreso.get('codpar')?.valueChanges.subscribe(() => {
      this.validarCorPar();
    });
  }
  save() {
    let f = this.f_pingreso.value;
    this.f_pingreso.patchValue({
      codigo: f.codpar,
    });
    if (f.codigo != f.codpar) {
      this.f_pingreso.invalid;
    }
    let presupuesto: Presupuesto = new Presupuesto();
    presupuesto.codigo = f.codigo;
    presupuesto.tippar = f.tippar;
    presupuesto.codpar = f.codpar;
    presupuesto.inicia = f.inicia;
    presupuesto.proyecto = f.idproyecto;
    presupuesto.clasificador = f.idclasificador;
    presupuesto.nompar = f.nompar;
    presupuesto.usucrea = 1;
    presupuesto.feccrea = this.date;
    presupuesto.totmod = 0;
    presupuesto.totcerti = 0;
    presupuesto.totmisos = 0;
    presupuesto.totdeven = 0;
    presupuesto.arrastre = 0;
    presupuesto.arrastreaa = 0;
    this.s_presupuesto.savePresupuesto(presupuesto).subscribe({
      next: (presupuesto: any) => {
      },
      error: (e: any) => console.error(e),
    });
  }
  get f() {
    return this.f_pingreso.controls;
  }
  validarCorPar() {
    // Obtén los valores de los controles del formulario
    let f = this.f_pingreso.value;
    const codparti = this.f_pingreso.get('codpar')?.value;

    const clasificador = this.f_pingreso.get('clasi_codpar')?.value;
    this.f_pingreso.patchValue({
      codigo: f.codpar,
    });
    // Verifica si ambos valores existen
    if (codparti && clasificador) {
      // Compara los valores
      const find = codparti.slice(0, clasificador.length);

      if (clasificador != find) {
        // Marca el control 'codparti' como inválido
        this.f_pingreso.get('codpar')?.setErrors({ mismatch: true });
      } else if (codparti.length < 14) {
        this.f_pingreso.get('codpar')?.setErrors({ mismatch: true });
      } else {
        // Limpia los errores si los valores coinciden
        this.f_pingreso.get('codpar')?.setErrors(null);
      }
    }
  }
  getClasificador() {
    let f = this.f_clasificador.value;
    if (f == '' || f == null) {
      this.s_clasificador.getAllClasificador().subscribe({
        next: (datos: any) => {
          this._clasificador = datos;
        },
      });
    } else {
      this.s_clasificador.getAllClasificadorByCodNom(f.codnompar).subscribe({
        next: (datos: any) => {
          this._clasificador = datos;
        },
      });
    }
  }
  setClasificador(clasificador: any) {
    this.f_pingreso.patchValue({
      clasi_codpar: clasificador.codpar,
      clasi_nompar: clasificador.nompar,
      idclasificador: clasificador,
      codpar: clasificador.codpar,
    });
  }
}

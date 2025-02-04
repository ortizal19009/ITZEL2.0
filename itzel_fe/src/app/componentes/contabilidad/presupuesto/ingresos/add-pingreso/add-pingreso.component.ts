import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { FilterPipe } from '../../../../../pipes/filter.pipe';
import { ClasificadorService } from '../../../../../servicios/contabilidad/clasificador.service';
@Component({
  selector: 'app-add-pingreso',
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    ReactiveFormsModule,
    FilterPipe,
  ],
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
  constructor(
    private fb: FormBuilder,
    private s_clasificador: ClasificadorService
  ) {}
  ngOnInit(): void {
    this.f_pingreso = this.fb.group({
      tippar: 1,
      codpar: '',
      codigo: '',
      nompar: '',
      inicia: 0.00,
      idproyecto: '',
      idclasificador: '',
      clasi_codpar: '',
      clasi_nompar: '',
    });
    this.f_clasificador = this.fb.group({
      codnompar: '',
    });
  }
  save() {
    console.log(this.f_clasificador.value);
  }
  getClasificador() {
    let f = this.f_clasificador.value;
    console.log(f);
    if (f == '' || f == null) {
      this.s_clasificador.getAllClasificador().subscribe({
        next: (datos: any) => {
          console.log(datos);
          this._clasificador = datos;
        },
      });
    } else {
      this.s_clasificador.getAllClasificadorByCodNom(f.codnompar).subscribe({
        next: (datos: any) => {
          console.log(datos);
          this._clasificador = datos;
        },
      });
    }
  }
  setClasificador(clasificador: any) {
    console.log(clasificador);
    this.f_pingreso.patchValue({
      clasi_codpar: clasificador.codpar,
      clasi_nompar: clasificador.nompar,
      idclasificador: clasificador,
      codpar: clasificador.codpar,
    });
  }
}

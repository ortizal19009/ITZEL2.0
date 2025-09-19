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
  f_proyecto!: FormGroup;
  _proyectos: any[] = [];
  _estructuras: any[] = [];
  maxLongitud: number = 0;

  constructor(
    private fb: FormBuilder,
    private proyectoService: ProyectoService,
    private estructuraService: EstructuraService
  ) {}

  ngOnInit(): void {
    this.f_proyecto = this.fb.group({
      codigo: ['', [Validators.required, Validators.minLength(2)]],
      nombre: ['', [Validators.required, Validators.minLength(3)]],
      estructura: [null, Validators.required],
    });

    // 🚀 Cargar todo en paralelo
    forkJoin({
      //proyectos: this.proyectoService.proyectoGetAll(),
      estructuras: this.estructuraService.estructuraGetAll(),
      maxLongitud: this.estructuraService.findTopByOrderByNivelDesc(),
    }).subscribe({
      next: (res: any) => {
        console.log(res);
        this._proyectos = res.proyectos;
        this._estructuras = res.estructuras;
        this.maxLongitud = res.maxLongitud.sumlongitud;

        // ⚡ Inicializa formulario cuando ya tienes los datos
        if (this._estructuras.length > 0) {
          this.f_proyecto.patchValue({
            estructura: this._estructuras[0],
          });
        }
      },
      error: (err) => console.error('❌ Error cargando datos:', err),
    });
  }

  // ejemplo de validación de código
  getValidacionCodigo(event: any) {
    if (!this._estructuras || this._estructuras.length === 0) {
      console.warn('⚠️ Estructuras aún no cargadas');
      return;
    }

    let code = event.target.value;
    console.log('Código ingresado:', code);
    // Aquí pones tu lógica de validación
  }

  onSubmit() {
    if (this.f_proyecto.valid) {
      console.log('✅ Proyecto listo para guardar:', this.f_proyecto.value);
      // llamar al servicio de guardar
    } else {
      console.warn('⚠️ Formulario inválido');
      this.f_proyecto.markAllAsTouched();
    }
  }
}

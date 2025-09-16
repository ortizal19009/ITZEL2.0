import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';

@Component({
  selector: 'app-certificaciones.component',
  imports: [RouterLink, CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './certificaciones.component.html',
  styleUrl: './certificaciones.component.css',
})
export class CertificacionesComponent implements OnInit {
  title: string = 'Certificaciones ';
  formBuscar!: FormGroup;
  swbuscando: boolean = false;
  txtbuscar: string = 'Buscando';
  certificacionesFiltradas: any[] = [];
  ordenColumna: keyof CertificacionVisual = 'codigo';
  ordenAscendente: boolean = true;

  constructor(private router: Router, private fb: FormBuilder) {}

  ngOnInit(): void {
    this.formBuscar = this.fb.group({
      buscar: '',
    });
  }
  buscar() {}
  cerrar() {
    this.router.navigate(['/inicio']);
  }
  ordenarPor(campo: keyof CertificacionVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.certificacionesFiltradas.sort((a: any, b: any) => {
      const valorA = a[campo];
      const valorB = b[campo];

      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;

      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';

      if (esNumero) {
        return this.ordenAscendente ? valorA - valorB : valorB - valorA;
      } else {
        return this.ordenAscendente
          ? String(valorA).localeCompare(String(valorB))
          : String(valorB).localeCompare(String(valorA));
      }
    });
  }
}
interface CertificacionVisual {
  codigo: string;
  nombre: string;
}

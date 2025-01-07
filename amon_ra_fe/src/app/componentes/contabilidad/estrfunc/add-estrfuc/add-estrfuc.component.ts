import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormsModule} from '@angular/forms';
import { Router } from '@angular/router';
import { EstructuraService } from '../../../../servicioss/contabilidad/estructura.service';
import { EstrfuncService } from '../../../../servicioss/contabilidad/estrfunc.service';

@Component({
  selector: 'app-add-estrfuc',
  imports: [CommonModule, FormsModule],
  templateUrl: './add-estrfuc.component.html',
  styleUrl: './add-estrfuc.component.css',
})
export class AddEstrfucComponent implements OnInit {
  title: string = 'Crear nueva funcion estructura';
  _estructuras: any;
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private estructuraService: EstructuraService,
    private estrfuncService: EstrfuncService
  ) {}
  ngOnInit(): void {
    this.estructuraGetAll();
  }
  estructuraGetAll() {
    this.estructuraService.estructuraGetAll().subscribe({
      next: (estructuras: any) => {
        console.table(estructuras);
        this._estructuras = estructuras;
      },
      error: (e: any) => console.error(e),
    });
  }
  regresar() {
    this.router.navigate(['/estrfunc']);
  }
  validarCodigo(e: any) {
  
  }
  getValidacionCodigo(codigo: string) {
    this.estrfuncService.validarCodigo(codigo).subscribe({
      next: (validador: any) => {
        return validador;
      },
      error: (e: any) => console.error(e),
    });
  }
}

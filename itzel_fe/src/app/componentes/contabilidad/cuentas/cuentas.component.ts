import { CommonModule } from '@angular/common';
import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { FilterPipe } from '../../../pipes/filter.pipe';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-cuentas',
  imports: [
    CommonModule,
    FormsModule,
    FilterPipe,
    ReactiveFormsModule,
    RouterLink,
    RouterLinkActive,
  ],
  templateUrl: './cuentas.component.html',
  styleUrl: './cuentas.component.css',
})
export class CuentasComponent implements OnInit {
  title: string = 'Cuentas';
  _cuentas?: any;
  stringFilter!: string;
  f_buscar!: FormGroup;

  /* variables para hacer la paginación  */
  page: number = 0;
  size: number = 20;
  _cuentasPageables?: any;
  totalPages: number = 0; // Total de páginas
  pages: number[] = []; // Lista de números de página
  maxPagesToShow: number = 5; // Máximo número de botones a mostrar
  constructor(private s_cuentas: CuentasService, private fb: FormBuilder) {}

  ngOnInit(): void {
    this.f_buscar = this.fb.group({
      codigo: '',
      denominacion: '',
    });
    this.getByPagesCuentas(0, 20);
  }

  getByPagesCuentas(page: number, size: number) {
    this.s_cuentas.getByPagesCuentas(page, size).subscribe({
      next: (datos: any) => {
        this.page = datos.pageable.pageNumber;
        this._cuentasPageables = datos;
        this._cuentas = datos.content;
        this.size = datos.size;
        this.totalPages = datos.totalPages;
        this.updatePages();
      },
      error: (e: any) => console.error(e),
    });
  }
  getByCodOrNom() {
    console.log(this.f_buscar.value);
    let f = this.f_buscar.value;
    if (f.codigo == '' && f.denominacion == '') {
      this.getByPagesCuentas(this.page, this.size);
    } else {
      this.s_cuentas
        .getByCodOrNom(f.codigo, f.denominacion, this.page, this.size)
        .subscribe({
          next: (datos: any) => {
            console.log(datos);
            this.page = datos.pageable.pageNumber;
            this._cuentasPageables = datos;
            this._cuentas = datos.content;
            this.size = datos.size;
            this.totalPages = datos.totalPages;
            this.updatePages();
          },
          error: (e: any) => console.error(e),
        });
    }
  }
  /* Inicio de configuracion de paginacion */
  onPreviousPage(): void {
    if (this.page > 0) {
      this.getByPagesCuentas(this.page - 1, this.size);
    }
  }
  onNextPage(): void {
    if (this.page <= this.totalPages - 1) {
      this.getByPagesCuentas(this.page + 1, this.size);
    }
  }
  onGoToPage(page: number): void {
    if (page >= 0 && page < this.totalPages) {
      this.getByPagesCuentas(page, this.size);
    }
  }
  updatePages(): void {
    const halfRange = Math.floor(this.maxPagesToShow / 2);
    let startPage = Math.max(this.page - halfRange, 0);
    let endPage = Math.min(this.page + halfRange, this.totalPages - 1);
    // Ajusta el rango si estás al principio o al final
    if (this.page <= halfRange) {
      endPage = Math.min(this.maxPagesToShow - 1, this.totalPages - 1);
    } else if (this.page + halfRange >= this.totalPages) {
      startPage = Math.max(this.totalPages - this.maxPagesToShow, 0);
    }
    // Genera los números de las páginas visibles
    this.pages = Array.from(
      { length: endPage - startPage + 1 },
      (_, i) => startPage + i
    );
  }
  /* Fin de configuracion de paginacion */
}

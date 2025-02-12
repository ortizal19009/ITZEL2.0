import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { FilterPipe } from '../../../../pipes/filter.pipe';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import { Router } from 'express';

@Component({
  selector: 'app-ingresos',
  imports: [
    CommonModule,
    FormsModule,
    FilterPipe,
    ReactiveFormsModule,
    RouterLink,
  ],
  templateUrl: './ingresos.component.html',
  styleUrl: './ingresos.component.css',
})
export class IngresosComponent implements OnInit {
  title: string = 'Presupuestos ingresos';
  f_buscar!: FormGroup;
  _presupuestos!: any;
  stringFilter!: string;
  /* variables para hacer la paginación  */
  page: number = 0;
  size: number = 10;
  _cuentasPageables?: any;
  totalPages: number = 0; // Total de páginas
  pages: number[] = []; // Lista de números de página
  maxPagesToShow: number = 5;
  constructor(
    private s_presupuestos: PresupuestoService,
    private fb: FormBuilder
  ) {}
  ngOnInit(): void {
    this.f_buscar = this.fb.group({
      dato: '',
    });
    this.getAllPresupuestos(this.page, this.size);
  }

  getAllPresupuestos(page: number, size: number) {
    let fb = this.f_buscar.value;
    if (fb.dato != '') {
      this.s_presupuestos
        .getByParDenom(fb.dato, 1, page, size)
        .then((item: any) => {
          this._presupuestos = item.content;
          this.size = item.size;
          this.page = item.pageable.pageNumber;
          this.totalPages = item.totalPages;
          this.updatePages();
        });
    } else {
      this.s_presupuestos
        .getPresupuestoTipparP(1, page, size)
        .then((item: any) => {
          this._presupuestos = item.content;
          this.size = item.size;
          this.page = item.pageable.pageNumber;
          this.totalPages = item.totalPages;
          this.updatePages();
        });
    }
  }

  /* Inicio de configuracion de paginacion */
  onPreviousPage(): void {
    if (this.page > 0) {
      //this.getByPagesCuentas(this.page - 1, this.size);
    }
  }
  onNextPage(): void {
    if (this.page <= this.totalPages - 1) {
      this.getAllPresupuestos(this.page + 1, this.size);
    }
  }
  onGoToPage(page: number): void {
    if (page >= 0 && page < this.totalPages) {
      this.getAllPresupuestos(page, this.size);
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

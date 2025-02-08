import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { FilterPipe } from '../../../../pipes/filter.pipe';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';

@Component({
  selector: 'app-gastos',
  imports: [CommonModule, FormsModule, FilterPipe, ReactiveFormsModule],
  templateUrl: './gastos.component.html',
  styleUrl: './gastos.component.css',
})
export class GastosComponent implements OnInit {
  title: string = 'Presupuestos gastos';
  f_buscar!: FormGroup;
  _presupuestos!: any;
  stringFilter!: string;
  /* variables para hacer la paginación  */
  page: number = 0;
  size: number = 20;
  _cuentasPageables?: any;
  totalPages: number = 0; // Total de páginas
  pages: number[] = []; // Lista de números de página
  maxPagesToShow: number = 5; // Máximo número de botones a mostrar
  constructor(
    private s_presupuestos: PresupuestoService,
    private fb: FormBuilder
  ) {}
  ngOnInit(): void {
    this.f_buscar = this.fb.group({
      codigo: '',
      denominacion: '',
    });
    this.getAllPresupuestos(this.page, this.size);
  }
  getAllPresupuestos(page: number, size: number) {
    this.s_presupuestos
      .getPresupuestoTipparP(2, page, size)
      .then((item: any) => {
        this._presupuestos = item.content;
        this.size = item.size;
        this.page = item.pageable.pageNumber;
        this.totalPages = item.totalPages;
        this.updatePages();
      });
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

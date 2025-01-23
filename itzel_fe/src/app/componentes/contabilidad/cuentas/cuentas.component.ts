import { CommonModule } from '@angular/common';
import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { FilterPipe } from '../../../pipes/filter.pipe';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';

@Component({
  selector: 'app-cuentas',
  imports: [CommonModule, FormsModule, FilterPipe],
  templateUrl: './cuentas.component.html',
  styleUrl: './cuentas.component.css',
})
export class CuentasComponent implements OnInit {
  title: string = 'Cuentas';
  _cuentas?: any;
  stringFilter!: string;

  constructor(
    private s_cuentas: CuentasService,
    private renderer: Renderer2,
    private el: ElementRef
  ) {}

  ngOnInit(): void {
    this.getAllCuentas();
  }
  getAllCuentas() {
    this.s_cuentas.getAllCuentas().subscribe({
      next: (datos: any) => {
        console.log(datos);
        this._cuentas = datos;
      },
      error: (e: any) => console.error(e),
    });
  }
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { EliminadosService } from '../../../../servicios/administracion/eliminados.service';
import { ColoresService } from '../../../../servicios/administracion/colores.service';

@Component({
  selector: 'app-ingresos.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './ingresos.component.html',
  styleUrl: './ingresos.component.css',
})
export class IngresosComponent implements OnInit {
  formBuscar!: FormGroup;
  txtbuscar: string = 'Buscar';
  swbuscando?: boolean;
  _movimientos: any[] = [];
  ventana: string = 'mov-ingresos';
  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private elimService: EliminadosService,
    private coloresService: ColoresService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', `/${this.ventana}`);
    let coloresJSON = sessionStorage.getItem(`/${this.ventana}`);
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();
    this.formBuscar = this.fb.group({
      desde: 0,
      hasta: 0,
      beneficiario: '',
      descripcion: '',
      filtroControl: '',
    });
  }
  nuevo() {
    this.router.navigate(['/add-mov-ingreso']);
  }
  imprimir() {}
  buscar() {}
  cerrar() {
    this.router.navigate(['/inicio']);
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(
        this.authService.idusuario!,
        `${this.ventana}`
      );
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem(`/${this.ventana}`, coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
    }
  }
}

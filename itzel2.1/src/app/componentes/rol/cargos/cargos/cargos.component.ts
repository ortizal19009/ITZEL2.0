import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { CargosService } from '../../../servicios/rol/cargos.service';
import { Cargos } from '../../../modelos/rol/cargos.model';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';
import { map } from 'rxjs';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';

@Component({
  selector: 'app-cargos',
  imports: [CommonModule, ReactiveFormsModule, VisualFormatDirective],
  templateUrl: './cargos.component.html',
  styleUrl: './cargos.component.css',
})
export class CargosComponent implements OnInit {
  formBuscar!: FormGroup;
  cargosFiltrados: Cargos[] = [];
  ordenColumna: keyof CargosVisual = 'nomcargo';
  ordenAscendente: boolean = true;
  iCargo = {} as interfaceCargos; //Interface para datos de eliminación
  formCargo!: FormGroup;
  swnuevo: boolean = false;
  swmodifi: boolean = false;
  idcargo!: number;
  antnomcargo!: string;
  excepcion: any; //Nuevo y actualizar
  excepcion1: any; //Eliminar

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private cargService: CargosService,
    private elimService: EliminadosService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/cargos');
    let coloresJSON = sessionStorage.getItem('/cargos');
    // console.log('coloresJSON: ', coloresJSON);
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    this.buscar();
  }

  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'cargos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/cargos', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error('Al buscar la ventana: ', error);
    }
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  buscar() {
    this.cargService.getListaCargos().subscribe({
      next: (datos) => (this.cargosFiltrados = [...datos]),
      error: (err) => console.error(err.error),
    });
  }

  ordenarPor(campo: keyof CargosVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.cargosFiltrados.sort((a, b) => {
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

  onCellClick(event: any, estrfunc: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('idestrfuncToInfo', estrfunc);
      this.router.navigate(['info-estrfunc']);
    }
  }

  toggleNuevo() {
    if (this.swmodifi) this.swmodifi = !this.swmodifi;
    this.swnuevo = !this.swnuevo;
    this.creaForm();
  }

  creaForm() {
    this.formCargo = this.fb.group(
      {
        nomcargo: [
          null,
          [Validators.required, Validators.minLength(3)],
          this.valNomcargo.bind(this),
        ],
        valor: [
          0,
          [Validators.required, Validators.pattern(/^-?\d+(\.\d{1,2})?$/), Validators.min(0)],
        ],
      },
      { updateOn: 'blur' }
    );
  }

  get f() {
    return this.formCargo.controls;
  }

  guardar() {
    // console.log(this.formCargo.value)
    let fecha: Date = new Date();
    let estrfunc: any; //Para no actualizar el formulario por el mensaje de validación
    estrfunc = this.formCargo.value;
    estrfunc.usucrea = this.authService.idusuario;
    estrfunc.feccrea = fecha;
    this.cargService.save(estrfunc).subscribe({
      next: () => {
        this.toggleNuevo();
        this.buscar();
      },
      error: (err) => {
        console.error(err.error);
        this.excepcion = err.error;
      },
    });
  }

  modificar(cargo: Cargos) {
    if (this.swnuevo) this.swnuevo = !this.swnuevo;
    this.swmodifi = !this.swmodifi;
    this.idcargo = cargo.idcargo;
    this.antnomcargo = cargo.nomcargo;
    this.creaForm();
    this.formCargo.patchValue({
      nomcargo: cargo.nomcargo,
      valor: cargo.valor,
    });
  }

  actualizar() {
    let fecha: Date = new Date();
    let cargo: Cargos; //Para no actualizar el formulario por el mensaje de validación
    cargo = this.formCargo.value;
    cargo.usumodi = this.authService.idusuario;
    cargo.fecmodi = fecha;
    this.cargService.update(this.idcargo, cargo).subscribe({
      next: () => {
        this.swmodifi = !this.swmodifi;
        this.buscar();
      },
      error: (err) => {
        this.excepcion = err.error;
        console.error(err.error);
      },
    });
  }

  //Datos a eliminar
  eliminar(cargo: Cargos) {
    this.iCargo.idcargo = cargo.idcargo;
    this.iCargo.nomcargo = cargo.nomcargo;
    this.iCargo.valor = cargo.valor;
    this.iCargo.cantidad = 0; //OJO: Temporal
    // this.cargService.contarEmpleadosPorIdcargo(cargo.idcargo).subscribe({
    //    next: cantidad => this.iEstrfunc.cantidad = cantidad,
    //    error: err => console.error('Al buscar si la Estrfunc tiene registros: ', err.error),
    // });
  }

  //Elimina
  elimina() {
    this.cargService.delete(this.iCargo.idcargo).subscribe({
      next: () => {
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'cargos';
        eliminado.tabla = 'CARGOS';
        eliminado.datos = `${this.iCargo.nomcargo} ${this.iCargo.valor} Falta contarEmpleadosPorIdcargo()`;
        this.elimService.save(eliminado).subscribe({
          next: () => this.buscar(),
          error: (err: any) => {
            console.error(err.error);
            this.excepcion1 = err.error;
          },
        });
      },
      error: (err) => {
        console.error(err.error);
        this.excepcion1 = err.error;
      },
    });
  }

  cerrar() {
    this.router.navigate(['/inicio']);
  }

  //Valida nomcargo
  valNomcargo(control: AbstractControl) {
    if (this.swnuevo) {
      return this.cargService
        .valNomcargo(control.value)
        .pipe(map((result: any) => (result ? { existe: true } : null)));
    } else {
      return this.cargService
        .valNomcargo(control.value)
        .pipe(
          map((result) => (control.value != this.antnomcargo && result ? { existe: true } : null))
        );
    }
  }
}

interface interfaceCargos {
  idcargo: number;
  nomcargo: string;
  valor: number;
  cantidad: number;
}

interface CargosVisual {
  nomcargo: string;
  valor: number;
}

import { Component, OnInit } from '@angular/core';
import { Destinos } from '../../../modelos/existencias/destinos.model';
import { AbstractControl, FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { DestinosService } from '../../../servicios/existencias/destinos.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { Router } from '@angular/router';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';
import { map } from 'rxjs';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-destinos.component',
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './destinos.component.html',
  styleUrl: './destinos.component.css',
})
export class DestinosComponent implements OnInit {
  formBuscar!: FormGroup;
  destFiltrados: Destinos[] = [];
  ordenColumna: keyof DestVisual = 'nomdestino';
  ordenAscendente: boolean = true;
  iDest = {} as interfaceDestinos; //Interface para datos de eliminación
  formDestino!: FormGroup;
  swnuevo: boolean = false;
  swmodifi: boolean = false;
  iddestino!: number;
  antnomdestino!: string;
  excepcion: any; //Nuevo y actualizar
  excepcion1: any; //Eliminar

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private destService: DestinosService,
    private elimService: EliminadosService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/destinos');
    let coloresJSON = sessionStorage.getItem('/destinos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    else this.buscaColor();

    this.buscar();
  }

  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'destinos');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/destinos', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error(error);
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

  public buscar() {
    this.destService.getListaDestinos().subscribe({
      next: (datos) => {
        // this._destinos = datos;
        this.destFiltrados = [...datos];
      },
      error: (err) => console.error(err.error),
    });
  }

  ordenarPor(campo: keyof DestVisual): void {
    if (this.ordenColumna === campo) {
      this.ordenAscendente = !this.ordenAscendente;
    } else {
      this.ordenColumna = campo;
      this.ordenAscendente = true;
    }

    this.destFiltrados.sort((a, b) => {
      const valorA = a[campo];
      const valorB = b[campo];

      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return 1;
      if (valorB == null) return -1;

      const esNumero = typeof valorA === 'number' && typeof valorB === 'number';

      return esNumero
        ? this.ordenAscendente
          ? valorA - valorB
          : valorB - valorA
        : this.ordenAscendente
        ? String(valorA).localeCompare(String(valorB))
        : String(valorB).localeCompare(String(valorA));
    });
  }

  onCellClick(event: any, destino: any) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('iddestinoToInfo', destino);
      this.router.navigate(['info-destino']);
    }
  }

  toggleNuevo() {
    if (this.swmodifi) this.swmodifi = !this.swmodifi;
    this.swnuevo = !this.swnuevo;
    this.creaForm();
  }

  creaForm() {
    this.formDestino = this.fb.group(
      {
        nomdestino: [
          null,
          [Validators.required, Validators.minLength(3)],
          this.valNomdest.bind(this),
        ],
      },
      { updateOn: 'blur' }
    );
  }

  get f() {
    return this.formDestino.controls;
  }

  guardar() {
    // console.log(this.formDestino.value)
    let fecha: Date = new Date();
    let destino: any; //Para no actualizar el formulario por el mensaje de validación
    destino = this.formDestino.value;
    destino.usucrea = this.authService.idusuario;
    destino.feccrea = fecha;
    this.destService.save(destino).subscribe({
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

  modificar(destino: Destinos) {
    if (this.swnuevo) this.swnuevo = !this.swnuevo;
    this.swmodifi = !this.swmodifi;
    this.iddestino = destino.iddestino;
    this.antnomdestino = destino.nomdestino;
    this.creaForm();
    this.formDestino.patchValue({
      nomdestino: destino.nomdestino,
    });
  }

  actualizar() {
    let fecha: Date = new Date();
    let destino: Destinos; //Para no actualizar el formulario por el mensaje de validación
    destino = this.formDestino.value;
    destino.usumodi = this.authService.idusuario;
    destino.fecmodi = fecha;
    this.destService.update(this.iddestino, destino).subscribe({
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
  eliminar(destino: Destinos) {
    this.iDest.iddestino = destino.iddestino;
    this.iDest.nomdestino = destino.nomdestino;
    this.iDest.cantidad = 0; //OJO: Temporal
    // this.nomiService.contarEmpleadosPorIddestino(cargo.idcargo).subscribe({
    //    next: cantidad => this.iEstrfunc.cantidad = cantidad,
    //    error: err => console.error('Al buscar si la Estrfunc tiene registros: ', err.error),
    // });
  }

  //Elimina
  elimina() {
    this.destService.delete(this.iDest.iddestino).subscribe({
      next: () => {
        let fecha: Date = new Date();
        let eliminado: Eliminados = new Eliminados();
        eliminado.idusuario = this.authService.idusuario!;
        eliminado.modulo = this.authService.moduActual;
        eliminado.fecha = fecha;
        eliminado.routerlink = 'profesiones';
        eliminado.tabla = 'PROFESIONES';
        eliminado.datos = `${this.iDest.nomdestino} Falta contarEmpleadosPorIdprofesion()`;
        this.elimService.save(eliminado).subscribe({
          next: () => this.buscar(),
          error: (err) => {
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

  //Valida nomdestino
  valNomdest(control: AbstractControl) {
    if (this.swnuevo) {
      return this.destService
        .valNomdest(control.value)
        .pipe(map((result) => (result ? { existe: true } : null)));
    } else {
      return this.destService
        .valNomdest(control.value)
        .pipe(
          map((result) => (control.value != this.antnomdestino && result ? { existe: true } : null))
        );
    }
  }
}

interface interfaceDestinos {
  iddestino: number;
  nomdestino: string;
  cantidad: number;
}

interface DestVisual {
  nomdestino: string;
}

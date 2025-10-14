import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  AsyncValidatorFn,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { Cuentas } from '../../../modelos/contabilidad/cuentas.model';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';
import { ArticulosService } from '../../../servicios/existencias/articulos.service';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { map, Observable, of } from 'rxjs';

@Component({
  selector: 'app-modi-articulo.component',
  imports: [CommonModule, ReactiveFormsModule, VisualFormatDirective],
  templateUrl: './modi-articulo.component.html',
  styleUrl: './modi-articulo.component.css',
})
export class ModiArticuloComponent implements OnInit {
  formArticulo!: FormGroup;
  movimientos: boolean = true;
  idarticulo!: number;
  _cuentas: Cuentas[] = [];
  idcuenta?: number | null;
  nomcue?: string = '';
  codcue?: string = '';
  antcodigo!: string;
  antnombre!: string;

  constructor(
    public fb: FormBuilder,
    private router: Router,
    public authService: AutorizaService,
    private artiService: ArticulosService,
    private cueService: CuentasService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/articulos');
    let coloresJSON = sessionStorage.getItem('/articulos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    this.idarticulo = +sessionStorage.getItem('idarticuloToModi')!;
    // console.log("idarticulo a modificar: " + this.idarticulo);

    let fecha: Date = new Date();
    this.formArticulo = this.fb.group(
      {
        nombre: [null, [Validators.required, Validators.minLength(3)], this.valNombre.bind(this)],
        codigo: [
          null,
          [Validators.required, Validators.minLength(2), Validators.maxLength(10)],
          this.valCodigo.bind(this),
        ],
        cuenta: ['', [Validators.required], [this.valCuenta()]],
        codcue: '',
        nomcue: '',
        unidad: [null, [Validators.required, Validators.minLength(2)]],
        minimo: '',
        maximo: '',
        swinmediato: '',
        descripcion: '',
        inicial: [0, [Validators.required, Validators.min(0)]],
        cosinicial: [0, [Validators.required, Validators.min(0)]],
        calctotal1: 0,
        actual: 0,
        cosactual: 0,
        calctotal2: 0,
        costotal: 0, //OJO: Evitar uso por promedios
        usumodi: this.authService.idusuario,
        fecmodi: fecha,
      },
      { updateOn: 'blur' }
    );
    // Suscribirse a los cambios de 'inicial' y 'cosinicial'
    this.formArticulo.get('inicial')!.valueChanges.subscribe((valor) => {
      this.actualizarCostotal();
    });
    this.formArticulo.get('cosinicial')!.valueChanges.subscribe((valor) => {
      this.actualizarCostotal();
    });
    this.buscaArticulo();
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  get f() {
    return this.formArticulo.controls;
  }

  buscaArticulo() {
    this.artiService.getByIdarticulo(this.idarticulo).subscribe({
      next: (articulo: Articulos) => {
        this.antcodigo = articulo.codigo;
        this.antnombre = articulo.nombre;
        this.idcuenta = articulo.cuenta.idcuenta;
        this.formArticulo.patchValue({
          codigo: articulo.codigo,
          nombre: articulo.nombre,
          cuenta: articulo.cuenta.codcue,
          codcue: articulo.codcue,
          nomcue: articulo.cuenta.nomcue,
          unidad: articulo.unidad,
          minimo: articulo.minimo,
          maximo: articulo.maximo,
          swinmediato: articulo.swinmediato,
          descripcion: articulo.descripcion,
          inicial: articulo.inicial,
          cosinicial: articulo.cosinicial,
          calctotal1: articulo.inicial * articulo.cosinicial,
          actual: articulo.actual,
          cosactual: articulo.cosactual,
          calctotal2: articulo.actual * articulo.cosactual,
        });
      },
      error: (err) => {
        console.error(err.error);
        this.authService.mostrarError('Error al buscar Artículo', err.error);
      },
    });
  }

  cuentaxCodcue(e: any) {
    if (e.target.value != '') {
      this.cueService.findByCodcue(e.target.value).subscribe({
        next: (datos) => (this._cuentas = datos),
        error: (err) => console.error(err.error),
      });
    }
  }
  onCuentaSelected(e: any): void {
    const selectedOption = this._cuentas.find((x: { codcue?: any }) => x.codcue === e.target.value);
    if (selectedOption) {
      this.idcuenta = selectedOption.idcuenta;
      this.nomcue = selectedOption.nomcue;
      this.codcue = selectedOption.codcue;
    } else {
      this.idcuenta = null;
      this.nomcue = '';
    }
  }

  // Actualiza costotal
  actualizarCostotal() {
    const inicial = this.formArticulo.get('inicial')!.value || 0;
    const cosinicial = this.formArticulo.get('cosinicial')!.value || 0;
    const calctotal1 = inicial * cosinicial;
    this.formArticulo.patchValue({
      actual: inicial,
      cosactual: cosinicial,
      calctotal1,
      calctotal2: calctotal1,
    });
  }

  actualizar() {
    let articulo: Articulos; //Para no actualizar el formulario por el mensaje de validación
    articulo = this.formArticulo.value;
    let cuenta: Cuentas = new Cuentas();
    cuenta.idcuenta = this.idcuenta!;
    articulo.cuenta = cuenta;
    this.artiService.updateArticulo(this.idarticulo, articulo).subscribe({
      next: () => this.regresar(),
      error: (err) => {
        console.error(err.error);
        this.authService.mostrarError('Error al actualizar', err.error);
      },
    });
  }

  regresar() {
    this.router.navigate(['/articulos']);
  }

  //Valida nombre
  valNombre(control: AbstractControl) {
    return this.artiService
      .valNombre(control.value)
      .pipe(map((result) => (control.value != this.antnombre && result ? { existe: true } : null)));
  }

  //Valida Codigo
  valCodigo(control: AbstractControl) {
    return this.artiService
      .valCodigo(control.value)
      .pipe(map((result) => (control.value != this.antcodigo && result ? { existe: true } : null)));
  }

  //Valida que se haya seleccionado una Cuenta
  valCuenta(): AsyncValidatorFn {
    return (_control: AbstractControl): Observable<ValidationErrors | null> => {
      const esValido = this.idcuenta != null;
      return of(esValido ? null : { invalido: true });
    };
  }
}

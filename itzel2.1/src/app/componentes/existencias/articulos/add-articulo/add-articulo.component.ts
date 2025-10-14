import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { Articulos } from '../../../modelos/existencias/articulos.model';
import { Cuentas } from '../../../modelos/contabilidad/cuentas.model';
import { AbstractControl, AsyncValidatorFn, FormBuilder, FormGroup, ReactiveFormsModule, ValidationErrors, Validators } from '@angular/forms';
import { map, Observable, of } from 'rxjs';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ArticulosService } from '../../../servicios/existencias/articulos.service';
import { CuentasService } from '../../../servicios/contabilidad/cuentas.service';

@Component({
  selector: 'app-add-articulo.component',
  imports: [CommonModule, ReactiveFormsModule, VisualFormatDirective],
  templateUrl: './add-articulo.component.html',
  styleUrl: './add-articulo.component.css',
})
export class AddArticuloComponent implements OnInit {
  @ViewChild('inputPrimero') inputPrimero!: ElementRef;

  formArticulo!: FormGroup;
  _cuentas: any[] = [];
  idcuenta?: number | null;
  nomcue: string = '';
  codcue: string = '';

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
    this.crearForm();
    // Suscribirse a los cambios de 'inicial' y 'cosinicial'
    this.formArticulo.get('inicial')!.valueChanges.subscribe((valor) => {
      this.actualizaTotal1();
    });
    this.formArticulo.get('cosinicial')!.valueChanges.subscribe((valor) => {
      this.actualizaTotal1();
    });
  }

  ngAfterViewInit(): void {
    this.inputPrimero.nativeElement.focus();
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  crearForm() {
    this.formArticulo = this.fb.group(
      {
        codigo: [
          null,
          [
            Validators.required,
            Validators.pattern(/^[A-Z0-9]+$/),
            Validators.minLength(2),
            Validators.maxLength(10),
          ],
          this.valCodigo(),
        ],
        nombre: [null, [Validators.required, Validators.minLength(3)], this.valNombre()],
        cuenta: ['', [Validators.required], [this.valCuenta()]],
        codcue: '',
        unidad: [null, [Validators.required, Validators.minLength(2)]],
        minimo: null,
        maximo: null,
        swinmediato: false,
        descripcion: '',
        inicial: [0, [Validators.required, Validators.min(0)]],
        cosinicial: [0, [Validators.required, Validators.min(0)]],
        calctotal1: 0,
        usucrea: this.authService.idusuario,
        feccrea: new Date(),
      },
      { updateOn: 'blur' }
    );
  }

  get f() {
    return this.formArticulo.controls;
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
    const selectedOption = this._cuentas.find((x: { codcue: any }) => x.codcue === e.target.value);
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
  actualizaTotal1() {
    const inicial = this.formArticulo.get('inicial')!.value || 0;
    const cosinicial = this.formArticulo.get('cosinicial')!.value || 0;
    const calctotal1 = inicial * cosinicial;
    this.formArticulo.patchValue({ calctotal1 });
  }

  regresar() {
    this.router.navigate(['/articulos']);
  }

  guardar() {
    let newarticulo: Articulos; //Para no actualizar el formulario por el mensaje de validación
    newarticulo = this.formArticulo.value;
    let cuenta: Cuentas = new Cuentas();
    cuenta.idcuenta = this.idcuenta!;
    newarticulo.cuenta = cuenta;
    newarticulo.codcue = this.codcue;
    newarticulo.actual = newarticulo.inicial;
    newarticulo.cosactual = newarticulo.cosinicial;
    newarticulo.costotal = this.formArticulo.value.calctotal1; //OJO: Temporal no se va a usar ?
    this.artiService.saveArticulo(newarticulo).subscribe({
      next: () => this.regresar(),
      error: (err) => {
        console.error(err.error);
        this.authService.mostrarError('Error al guardar', err.error);
      },
    });
  }

  //Valida Codigo
  valCodigo(): AsyncValidatorFn {
    return (control: AbstractControl): Observable<ValidationErrors | null> => {
      return this.artiService
        .valCodigo(control.value)
        .pipe(map((result) => (result ? { existe: true } : null)));
    };
  }

  //Valida nombre
  valNombre(): AsyncValidatorFn {
    return (control: AbstractControl): Observable<ValidationErrors | null> => {
      return this.artiService
        .valNombre(control.value)
        .pipe(map((result) => (result ? { existe: true } : null)));
    };
  }

  //Valida que se haya seleccionado una Cuenta
  valCuenta(): AsyncValidatorFn {
    return (_control: AbstractControl): Observable<ValidationErrors | null> => {
      const esValido = this.idcuenta != null;
      return of(esValido ? null : { invalido: true });
    };
  }
}

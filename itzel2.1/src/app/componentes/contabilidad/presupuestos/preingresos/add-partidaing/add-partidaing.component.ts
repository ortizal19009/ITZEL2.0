import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AbstractControl, FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import { ClasificadorService } from '../../../../servicios/contabilidad/clasificador.service';
import { Clasificador } from '../../../../modelos/contabilidad/clasificador.model';
import { map, of } from 'rxjs';

@Component({
  selector: 'app-add-partidaing.component',
  imports: [ReactiveFormsModule, CommonModule],
  templateUrl: './add-partidaing.component.html',
  styleUrl: './add-partidaing.component.css',
})
export class AddPartidaingComponent {
  formPartidaing: any;
  longitudCodpar!: number;
  idclasificador: number | null = null;
  _clasificador: any[] = [];
  filtro!: string;
  swvalido = 1; //Búsqueda de Partida en el Clasificador Presupuestario
  privez = true; //Para resetear los datos de Búsqueda en el Clasificador

  constructor(
    public router: Router,
    public fb: FormBuilder,
    public fb1: FormBuilder,
    private authService: AutorizaService,
    private presuService: PresupuestoService,
    private clasiService: ClasificadorService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/preingresos');
    let coloresJSON = sessionStorage.getItem('/preingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    this.longitudCodpar = 14;

    let date: Date = new Date();
    this.formPartidaing = this.fb.group({
      tippar: 1,
      idclasificador: ['', [Validators.required], [this.valClasificador.bind(this)]],
      codpar: [
        null,
        [
          Validators.required,
          Validators.minLength(this.longitudCodpar),
          Validators.minLength(this.longitudCodpar),
        ],
        this.valCodpar.bind(this),
      ],
      codigo: '',
      nompar: [null, [Validators.required, Validators.minLength(3)]],
      inicial: 0,
      totmod: 0,
      totcerti: 0,
      totmisos: 0,
      totdeven: 0,
      usucrea: this.authService.idusuario,
      feccrea: date,
    });
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }

  get codpar() {
    return this.formPartidaing.get('codpar');
  }
  get nompar() {
    return this.formPartidaing.get('nompar');
  }
  get f() {
    return this.formPartidaing.controls;
  }

  onSubmit() {
    // this.preingForm.controls['codigo'].setValue(this.preingForm.value.codpar);
    // this.presuService.save(this.preingForm.value).subscribe({
    //    next: resp => {
    //       this.regresar();
    //    },
    //    error: err => console.log(err.error)
    // });
  }

  clasixCodpar(e: any) {
    if (e.target.value != '') {
      this.clasiService.findPartidasing(e.target.value).subscribe({
        next: (datos) => (this._clasificador = datos),
        error: (err) => console.error(err.error),
      });
    }
  }
  onClasiSelected(e: any) {
    console.log('e.target.value: ', e.target.value);
    const selectedOption = this._clasificador.find(
      (x: { codpar: any }) => x.codpar === e.target.value
    );
    console.log('selectedOption: ', selectedOption);
    if (selectedOption) this.idclasificador = selectedOption.idclasificador;
    else this.idclasificador = null;
    console.log('this.idclasificador: ', this.idclasificador);
  }

  clasificadorModal() {
    // this.swvalido = 1;
    // if (this.privez) this.privez = false;
    // else {
    //    this.formBusClasificador.reset();
    //    this._clasificador = [];
    // }
  }

  buscarClasificador() {
    // if (this.formBusClasificador.value.codpar == null) this.formBusClasificador.value.codpar = '';
    // if (this.formBusClasificador.value.nompar == null) this.formBusClasificador.value.nompar = '';
    // this.clasiService.getParingreso(this.formBusClasificador.value.codpar, this.formBusClasificador.value.nompar).subscribe({
    //    next: datos => this._clasificador = datos,
    //    error: err => console.log(err.error)
    // });
  }

  selecClasificador(partida: Clasificador) {
    this.formPartidaing.controls['intcla'].setValue(partida);
    this.formPartidaing.controls['codpart'].setValue(partida.codpar);
    this.formPartidaing.controls['nomcla'].setValue(partida.nompar);
    this.formPartidaing.controls['codpar'].setValue(partida.codpar);
  }

  regresar() {
    this.router.navigate(['/preingresos']);
  }

  //Valida que se haya seleccionado un partida del clasificador
  valClasificador(control: AbstractControl) {
    if (this.idclasificador == null) return of({ invalido: true });
    else return of(null);
  }

  //Valida codpar
  valCodpar(control: AbstractControl) {
    return this.presuService
      .valCodpar(control.value)
      .pipe(map((result) => (result ? { existe: true } : null)));
  }
  //Valida nompar
  valNompar(control: AbstractControl) {
    return this.presuService
      .valNompar(control.value)
      .pipe(map((result) => (result ? { existe: true } : null)));
  }
}

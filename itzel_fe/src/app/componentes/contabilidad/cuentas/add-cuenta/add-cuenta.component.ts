import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute, Route, Router, RouterLink } from '@angular/router';
import { CuentasService } from '../../../../servicios/contabilidad/cuentas.service';
import { Ifinan } from '../../../../modelos/contabilidad/ifinan';
import { Cuentas } from '../../../../modelos/contabilidad/cuentas';
import { TiptranService } from '../../../../servicios/contabilidad/tiptran.service';
import { NivelesService } from '../../../../servicios/contabilidad/niveles.service';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-cuenta',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, RouterLink],
  templateUrl: './add-cuenta.component.html',
  styleUrl: './add-cuenta.component.css',
})
export class AddCuentaComponent implements OnInit {
  idcuenta!: number;
  _cuenta?: any;
  f_cuenta!: FormGroup;
  title: string = 'Nueva Cuenta';
  sw_codigo: Boolean = false;
  sw_nombre: Boolean = false;
  _niveles?: any;
  _request?: any;
  tiptrans?: any;
  _codPartida: any = '';
  _tippar?: any;
  _presupuestos?: any;
  constructor(
    private _params: ActivatedRoute,
    private s_cuentas: CuentasService,
    private fb: FormBuilder,
    private s_tiptran: TiptranService,
    private s_nivel: NivelesService,
    private s_presupuestos: PresupuestoService
  ) {}
  ngOnInit(): void {
    this.idcuenta = +this._params.snapshot.paramMap.get('idcuenta')!;
    this.f_cuenta = this.fb.group({
      codcue: ['', Validators.required],
      nomcue: ['', Validators.required],
      movcue: [false, Validators.required],
      nivel: ['', Validators.required],
      grucue: ['', Validators.required],
      nomgrup: ['', Validators.required],
      asodebe: ['', Validators.required],
      asohaber: ['', Validators.required],
      tiptran: [0, Validators.required],
      sigef: ['', Validators.required],
      grubalances: ['', Validators.required],
      grufluefec: ['', Validators.required],
      balancostos: ['', Validators.required],
    });
    this.getCuentaById(this.idcuenta);
    this.getAllTipTran();
    this.getAllNiveles();
  }
  get f() {
    return this.f_cuenta.controls;
  }
  getAllTipTran() {
    this.s_tiptran.getAllTiptran().subscribe({
      next: (_tiptran: any) => {
        this.tiptrans = _tiptran;
      },
      error: (e: any) => console.error(e),
    });
  }
  getAllNiveles() {
    this.s_nivel.getAll().subscribe({
      next: (_niveles: any) => {
        console.log(_niveles);
        this._niveles = _niveles;
        this.f_cuenta.patchValue({
          nivel: _niveles[0],
        });
      },
    });
  }
  getCuentaById(idcuenta: number) {
    this.s_cuentas.getByIdCuenta(idcuenta).subscribe({
      next: (datos: any) => {
        this._cuenta = datos;
        this.f_cuenta.patchValue({
          grucue: datos.grucue,
          nomcue: datos.nomcue,
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  getValidarNombre(e: any) {}
  getValidacionCodigo(e: any) {}
  getAsoDebeHaber() {
    console.log(this._codPartida);
    this.s_presupuestos
      .findTipparAndCodpar(this._tippar, this._codPartida)
      .subscribe({
        next: (_presupuesto: any) => {
          if (_presupuesto.body?.length > 0) {
            const f = this.f_cuenta.value;
            this._presupuestos = _presupuesto.body;
            console.log(_presupuesto);
          }
          this.swal(_presupuesto.status, _presupuesto.message);
        },
        error: (e: any) => console.error(e),
      });
  }

  save() {
    let cuenta!: Cuentas;
    let f = this.f_cuenta.value;
    cuenta.codcue = f.cuenta;
    cuenta.nomcue = f.nomcue;
    cuenta.movcue = f.movcue;
    cuenta.nivel = f.nivel;

    console.log(cuenta);
  }
  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
    });
  }
}

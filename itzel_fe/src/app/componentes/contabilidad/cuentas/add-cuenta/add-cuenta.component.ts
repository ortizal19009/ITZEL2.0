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
  tiptrans: any = [{ name: '(General)', key: 0 }];
  constructor(
    private _params: ActivatedRoute,
    private s_cuentas: CuentasService,
    private fb: FormBuilder,
    private router: Router
  ) {}
  ngOnInit(): void {
    this.idcuenta = +this._params.snapshot.paramMap.get('idcuenta')!;
    this.f_cuenta = this.fb.group({
      codcue: ['',Validators.required],
      nomcue: ['',Validators.required],
      movcue: [false,Validators.required],
      nivel: ['',Validators.required],
      grucue: ['',Validators.required],
      nomgrup: ['',Validators.required],
      asodebe: ['',Validators.required],
      asohaber: ['',Validators.required],
      tiptran: [0,Validators.required],
      sigef: ['',Validators.required],
      grubalances: ['',Validators.required],
      grufluefec: ['',Validators.required],
      balancostos: ['',Validators.required],
    });
    this.getCuentaById(this.idcuenta);
  }
  get f() {
    return this.f_cuenta.controls;
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
  save() {
    let cuenta!: Cuentas;
    let f = this.f_cuenta.value;
    cuenta.codcue = f.cuenta;
    cuenta.nomcue = f.nomcue;
    cuenta.movcue = f.movcue;
    cuenta.nivel = f.nivel;
  }
}

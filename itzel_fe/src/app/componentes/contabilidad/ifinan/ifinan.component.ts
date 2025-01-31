import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  FormsModule,
  Validators,
} from '@angular/forms';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { FilterPipe } from '../../../pipes/filter.pipe';
import { IfinanService } from '../../../servicios/contabilidad/ifinan.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { map } from 'rxjs';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { AddIfinanComponent } from "./add-ifinan/add-ifinan.component";

@Component({
  selector: 'app-ifinan',
  imports: [CommonModule, FormsModule, FilterPipe, RouterLink, RouterLinkActive, AddIfinanComponent],
  templateUrl: './ifinan.component.html',
  styleUrl: './ifinan.component.css',
})
export class IfinanComponent implements OnInit {
  title: string = 'Instituciones financieras';
  stringFilter!: string;
  _ifinan?: any;
  formIfinan!: FormGroup;
  filtro?: string;
  idifinan!: number;
  opcion?: number; //1: Nuevo, 2: Modificar
  antcodifinan?: String;
  antnomifinan?: String;
  totbenefi: number = 1;
  constructor(
    public fb: FormBuilder,
    private ifinanService: IfinanService,
    private router: Router,
    private beneService: BeneficiariosService,
    private serverConfigService: ServerConfigService
  ) {}
  ngOnInit(): void {
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue.toString();
    });
    this.creaForm();
    this.listar();
  }
  public listar() {
    this.ifinanService.getListaIfinans().subscribe({
      next: (datos: any) => {
        this._ifinan = datos;
      },
      error: (err) => console.error(err.error),
    });
  }

  creaForm() {
    this.formIfinan = this.fb.group({
      nomifinan: [
        '',
        [Validators.required, Validators.minLength(3)],
        this.valNomifinan.bind(this),
      ],
      codifinan: [
        '',
        [Validators.required, Validators.minLength(8), Validators.maxLength(8)],
        this.valCodifinan.bind(this),
      ],
    });
  }

  get f() {
    return this.formIfinan.controls;
  }

  onCellClick(event: any, idifinan: number) {
    const tagName = event.target.tagName;
    if (tagName === 'TD') {
      sessionStorage.setItem('idifinanToInfo', idifinan.toString());
      this.router.navigate(['info-ifinan']);
    }
  }

  nuevo() {
    this.opcion = 1;
    this.creaForm();
  }

  modificar(ifinan: any) {
    this.opcion = 2;
    this.creaForm();
    this.idifinan = ifinan.idifinan;
    this.antcodifinan = ifinan.codifinan;
    this.antnomifinan = ifinan.nomifinan;
    this.formIfinan.setValue({
      nomifinan: ifinan.nomifinan,
      codifinan: ifinan.codifinan,
    });
  }

  guardar() {
    if (this.opcion == 1) this.newIfinan();
    if (this.opcion == 2) this.actuIfinan();
  }

  newIfinan() {
    this.ifinanService.saveIfinancieras(this.formIfinan.value).subscribe({
      next: (resp) => this.listar(),
      error: (err) => console.error('Al guardar la nueva Ifinan: ', err.error),
    });
  }

  actuIfinan() {
    this.ifinanService.update(this.idifinan, this.formIfinan.value).subscribe({
      next: (resp) => this.listar(),
      error: (err) => console.error('Al modificar la Ifinan: ', err.error),
    });
  }

  eliminar(ifinan: any) {
    this.antnomifinan = ifinan.nomifinan; //Para el mensaje de eliminar
    this.idifinan = ifinan.idifinan;
    this.totbenefi = 1; //Para que por default no pueda eliminar
    this.beneService.countByIdifinan(ifinan.idifinan).subscribe({
      next: (resp) => (this.totbenefi = resp),
      error: (err) =>
        console.error('Al contar los Beneficiarios por Idifinan: ', err.error),
    });
  }

  elimina() {
    if (this.idifinan != null) {
      this.ifinanService.deleteIfinan(this.idifinan).subscribe({
        next: (resp) => this.listar(),
        error: (err) =>
          console.error('Al eliminar una Institución Financiera: ', err.error),
      });
    }
  }

  //Valida Nomifinan
  valNomifinan(control: AbstractControl) {
    if (this.opcion == 1) {
      return this.ifinanService
        .valNomifinan(control.value)
        .pipe(map((result) => (result ? { existe: true } : null)));
    } else {
      return this.ifinanService
        .valNomifinan(control.value)
        .pipe(
          map((result) =>
            result && control.value != this.antnomifinan
              ? { existe: true }
              : null
          )
        );
    }
  }

  //Valida Codifinan
  valCodifinan(control: AbstractControl) {
    if (this.opcion == 1) {
      return this.ifinanService
        .valCodifinan(control.value)
        .pipe(map((result) => (result ? { existe: true } : null)));
    } else {
      return this.ifinanService
        .valCodifinan(control.value)
        .pipe(
          map((result) =>
            result && control.value != this.antcodifinan
              ? { existe: true }
              : null
          )
        );
    }
  }
}

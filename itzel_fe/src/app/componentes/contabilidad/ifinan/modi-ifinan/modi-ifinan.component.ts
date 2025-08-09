import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import {
  ActivatedRoute,
  Router,
  RouterLink,
  RouterLinkActive,
} from '@angular/router';
import { FilterPipe } from '../../../../pipes/filter.pipe';
import { AddIfinanComponent } from '../add-ifinan/add-ifinan.component';
import { IfinanService } from '../../../../servicios/contabilidad/ifinan.service';
import { BeneficiariosService } from '../../../../servicios/contabilidad/beneficiarios.service';
import { ServerConfigService } from '../../../../servicios/config/server-config.service';
import { map } from 'rxjs';

@Component({
  selector: 'app-modi-ifinan',
  imports: [CommonModule, FormsModule, RouterLink, ReactiveFormsModule],
  templateUrl: './modi-ifinan.component.html',
  styleUrl: './modi-ifinan.component.css',
})
export class ModiIfinanComponent implements OnInit {
  title: string = 'Nueva institución financiera';
  f_ifinan!: FormGroup;
  sw_codifinan: Boolean = true;
  sw_nomifinan: Boolean = true;
  _request: any;
  _idifinan?: number;
  constructor(
    private _params: ActivatedRoute,
    public fb: FormBuilder,
    private ifinanService: IfinanService,
    private router: Router,
    private beneService: BeneficiariosService,
    private serverConfigService: ServerConfigService,
    private s_ifinan: IfinanService
  ) {}
  ngOnInit(): void {
    this._idifinan = +this._params.snapshot.paramMap.get('idifinan')!;
    this.f_ifinan = this.fb.group({
      idifinan: [this._idifinan, Validators.required],
      codifinan: ['', Validators.required],
      nomifinan: ['', Validators.required],
      foto: '',
    });
    this.getByIdIfinan(this._idifinan);
  }
  getValidacionCodigo(e: any) {}
  getValidarNombre(e: any) {}
  regresar() {}
  getByIdIfinan(idifinan: number) {
    this.s_ifinan.getById(idifinan).subscribe({
      next: (ifinan: any) => {
        this.f_ifinan.patchValue({
          idifinan: ifinan.idifinan,
          codifinan: ifinan.codifinan,
          nomifinan: ifinan.nomifinan,
          foto: ifinan.foto,
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  get f() {
    return this.f_ifinan.controls;
  }
  save() {
    this.s_ifinan
      .update(this.f_ifinan.value.idifinan, this.f_ifinan.value)
      .subscribe({
        next: (data: any) => {
          this._request = data.message;
          this.f_ifinan.reset();
          this.router.navigate(['/ifinan']);
          setTimeout(() => {
            this._request = '';
          }, 3000);
        },
        error: (e: any) => console.error(e),
      });
  }
}

import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { IfinanService } from '../../../servicios/contabilidad/ifinan.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-add-ifinan',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './add-ifinan.component.html',
  styleUrl: './add-ifinan.component.css',
})
export class AddIfinanComponent implements OnInit {
  title: string = 'Nueva institución financiera';
  f_ifinan!: FormGroup;
  sw_codifinan: Boolean = true;
  sw_nomifinan: Boolean = true;
  _request: any;
  constructor(private fb: FormBuilder, private s_ifinan: IfinanService, private router: Router) {}
  ngOnInit(): void {
    this.f_ifinan = this.fb.group({
      codifinan: ['', Validators.required],
      nomifinan: ['', Validators.required],
      foto: '',
    });
  }
  getValidacionCodigo(e: any) {}
  getValidarNombre(e: any) {}
  regresar() {
    this.router.navigate(['/ifinan']);
  }
  // atajo para acceder a los controles en el template
  get f() {
    return this.f_ifinan.controls;
  }
  save() {
    this.s_ifinan.saveIfinancieras(this.f_ifinan.value).subscribe({
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

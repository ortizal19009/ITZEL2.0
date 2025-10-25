import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { ArticulosService } from '../../../../servicios/existencias/articulos.service';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { Documentos } from '../../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../../servicios/administracion/documentos.service';

@Component({
  selector: 'app-add-ingreso.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './add-ingreso.component.html',
  styleUrl: './add-ingreso.component.css',
})
export class AddIngresoComponent implements OnInit {
  formMovimiento!: FormGroup;
  today: Date = new Date();
  _documentos: Documentos[] = [];
  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private s_documentos: DocumentosService
  ) {}
  ngOnInit(): void {
    this.getAllDocumentos();

    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/mov-ingresos');

    let coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    this.formMovimiento = this.fb.group({
      numero: ['', [Validators]],
      tipmov: 1,
      fecha: [this.today.toISOString().substring(0, 10), [Validators.required]],
      numentrada: '',
      total: '',
      numart: '',
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      documento: '',
      fecdoc: [this.today.toISOString().substring(0, 10), [Validators.required]],
      swaprobado: false,
    });
  }
  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
    this.formMovimiento = this.fb.group({});
  }
  get f() {
    return this.formMovimiento.controls;
  }
  numAvailable(e: any) {}
  getAllDocumentos() {
    this.s_documentos.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        console.log(data);
        this._documentos = data;
      },
      error: (e) => console.error(e.error),
    });
  }
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-ingreso.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './add-ingreso.component.html',
  styleUrl: './add-ingreso.component.css',
})
export class AddIngresoComponent implements OnInit {
  formMovimiento!: FormGroup;
  constructor(private router: Router, private fb: FormBuilder) {}
  ngOnInit(): void {
    let coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
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
}

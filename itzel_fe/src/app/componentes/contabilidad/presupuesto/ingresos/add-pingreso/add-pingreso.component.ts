import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { FilterPipe } from '../../../../../pipes/filter.pipe';

@Component({
  selector: 'app-add-pingreso',
  imports: [CommonModule, FormsModule, RouterLink, ReactiveFormsModule],
  templateUrl: './add-pingreso.component.html',
  styleUrl: './add-pingreso.component.css',
})
export class AddPingresoComponent implements OnInit {
  title: string = 'Nuevo presupuesto de ingreso';
  f_pingreso!: FormGroup;
  _request?: string;
  constructor(private fb: FormBuilder) {}
  ngOnInit(): void {
    this.f_pingreso = this.fb.group({
      tippar: 1,
      codpar: '',
      codigo: '',
      nompar: '',
      inicia: '',
      idproyecto: '',
      idclasificador: '',
    });
  }
  save() {}
}

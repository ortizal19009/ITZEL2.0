import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { FilterPipe } from '../../../pipes/filter.pipe';
import { IfinanService } from '../../../servicios/contabilidad/ifinan.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';

@Component({
  selector: 'app-ifinan',
  imports: [CommonModule, RouterLink, FormsModule, FilterPipe],
  templateUrl: './ifinan.component.html',
  styleUrl: './ifinan.component.css',
})
export class IfinanComponent implements OnInit {
  title: string = 'Instituciones financieras';
  stringFilter!: string;
  _ifinan?: any;
  formIfinan?: FormGroup;
  filtro?: string;
  idifinan?: number;
  opcion?: number; //1: Nuevo, 2: Modificar
  antcodifinan?: String;
  antnomifinan?: String;
  totbenefi: number = 1;
  constructor(
    public fb: FormBuilder, private ifinanService: IfinanService, private router: Router,
    private beneService: BeneficiariosService) {}
  ngOnInit(): void {}
  onCellClick(e: any, idifinan: number) {}
  modificar(ifinan: any) {}
  eliminar(ifinan: any) {}
}

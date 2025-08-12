import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-info-proyecto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './info-proyecto.component.html',
  styleUrl: './info-proyecto.component.css',
})
export class InfoProyectoComponent implements OnInit {
  title: string = 'Información de proyecto';
  constructor() {}
  ngOnInit(): void {}
}

import { Component, OnInit } from '@angular/core';
import { ProyectosService } from '../../../servicioss/contabilidad/proyectos.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-proyectos',
  imports: [CommonModule,RouterLink ],
  templateUrl: './proyectos.component.html',
  styleUrl: './proyectos.component.css',
})
export class ProyectosComponent implements OnInit {
  title?: string = 'Estructura función';
  _proyectos?: any;
  stringFilter?: string;
  constructor(private proyectosService: ProyectosService) {}
  ngOnInit(): void {
    this.getAllProyectos();
  }
  getAllProyectos() {
    this.proyectosService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {
        console.table(proyectos);
        this._proyectos = proyectos;
      },
    });
  }
}

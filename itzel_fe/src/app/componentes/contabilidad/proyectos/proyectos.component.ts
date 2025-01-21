import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { ProyectosService } from '../../../servicios/contabilidad/proyectos.service';
import { ServerConfigService } from '../../../servicios/config/server-config.service';
import { FilterPipe } from '../../../pipes/filter.pipe';

@Component({
  selector: 'app-proyectos',
  imports: [CommonModule, RouterLink, FormsModule, FilterPipe],
  templateUrl: './proyectos.component.html',
  styleUrl: './proyectos.component.css',
})
export class ProyectosComponent implements OnInit {
  title?: string = 'Estructura función';
  _proyectos?: any;
  stringFilter!: string;
  constructor(
    private proyectosService: ProyectosService,
    private serverConfigService: ServerConfigService
  ) {}
  ngOnInit(): void {
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      console.warn(filterValue);
      this.stringFilter = filterValue;
    });
    this.getAllProyectos();
  }
  getAllProyectos() {
    this.proyectosService.proyectosGetAll().subscribe({
      next: (proyectos: any) => {
        this._proyectos = proyectos;
      },
    });
  }
}

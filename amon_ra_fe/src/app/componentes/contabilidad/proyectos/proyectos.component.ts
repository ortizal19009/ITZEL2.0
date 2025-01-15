import { Component, OnInit } from '@angular/core';
import { ProyectosService } from '../../../servicioss/contabilidad/proyectos.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { FilterPipe } from '../../../pipes/filter.pipe';
import { FormsModule } from '@angular/forms';
import { ServerConfigService } from '../../../servicioss/config/server-config.service';

@Component({
  selector: 'app-proyectos',
  imports: [CommonModule, RouterLink, FilterPipe, FormsModule],
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

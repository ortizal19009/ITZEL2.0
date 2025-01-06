import { Component, OnInit } from '@angular/core';
import { EstrfuncService } from '../../../servicioss/contabilidad/estrfunc.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-estrfunc',
  imports: [CommonModule],
  templateUrl: './estrfunc.component.html',
  styleUrl: './estrfunc.component.css',
})
export class EstrfuncComponent implements OnInit {
  title?: string = 'Estructura función';
  _estrfunc?: any;
  constructor(private estrfuncService: EstrfuncService) {}
  ngOnInit(): void {
    this.estrfuncService.getAll().subscribe({
      next: (_datos?: any) => {
        console.log(_datos);
        this._estrfunc = _datos;
      },
    });
  }
}

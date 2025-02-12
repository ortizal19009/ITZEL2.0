import { Component, OnInit } from '@angular/core';
import { ServerConfigService } from '../../servicios/config/server-config.service';

@Component({
  selector: 'app-main-header',
  imports: [],
  templateUrl: './main-header.component.html',
  styleUrl: './main-header.component.css',
})
export class MainHeaderComponent implements OnInit {
  constructor(private serverConfigService: ServerConfigService) {}
  ngOnInit(): void {}
  onFilterChange(filterValue: any) {
    let dato: string = filterValue.target.value;
    this.serverConfigService.updateFilter(dato); // Enviar el valor al servicio
  }

}

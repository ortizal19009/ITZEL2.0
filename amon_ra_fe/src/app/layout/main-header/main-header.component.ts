import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ServerConfigService } from '../../servicioss/config/server-config.service';

@Component({
  selector: 'app-main-header',
  imports: [FormsModule],
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

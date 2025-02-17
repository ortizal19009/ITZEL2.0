import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MainHeaderComponent } from "./layout/main-header/main-header.component";

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, MainHeaderComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'AMON-RA';
}

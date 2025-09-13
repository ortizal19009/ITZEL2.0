import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MainHeaderComponent } from "./componentes/layout/main-header/main-header.component";
import { MainSidebar } from "./componentes/layout/main-sidebar/main-sidebar";
import { MainFooter } from "./componentes/layout/main-footer/main-footer";

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, MainHeaderComponent, MainSidebar, MainFooter],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('itzel2.1');
}

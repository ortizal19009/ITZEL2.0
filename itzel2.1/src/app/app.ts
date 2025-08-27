import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MainHeader } from "./componentes/layout/main-header/main-header";
import { MainSidebar } from "./componentes/layout/main-sidebar/main-sidebar";
import { MainFooter } from "./componentes/layout/main-footer/main-footer";

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, MainHeader, MainSidebar, MainFooter],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
  protected readonly title = signal('itzel2.1');
}

import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MainHeaderComponent } from './layout/main-header/main-header.component';
import { MainSidebarComponent } from './layout/main-sidebar/main-sidebar.component';
import { MainFooterComponent } from './layout/main-footer/main-footer.component';

@Component({
  selector: 'app-root',
  imports: [
    RouterOutlet,
    MainHeaderComponent,
    MainSidebarComponent,
    MainFooterComponent,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'ITZEL 2.0';

}

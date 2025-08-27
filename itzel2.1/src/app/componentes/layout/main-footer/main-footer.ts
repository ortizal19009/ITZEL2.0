import { Component } from '@angular/core';

@Component({
  selector: 'app-main-footer',
  imports: [],
  templateUrl: './main-footer.html',
  styleUrl: './main-footer.css',
})
export class MainFooter {
  today = new Date();
  currentYear = this.today.getFullYear();
}

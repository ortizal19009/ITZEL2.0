import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ServerConfigService {
  constructor() {}
  private filterSubject = new BehaviorSubject<string>(''); // Observa el valor del filtro
  currentFilter = this.filterSubject.asObservable();

  updateFilter(filterValue: string) {
    this.filterSubject.next(filterValue);
  }
}

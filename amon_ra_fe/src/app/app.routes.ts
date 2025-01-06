import { Routes } from '@angular/router';
import { AppWrapperComponent } from './layout/app-wrapper/app-wrapper.component';
import { EstrfuncComponent } from './componentes/contabilidad/estrfunc/estrfunc.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  { path: 'estrfunc', component: EstrfuncComponent },
  { path: '', redirectTo: 'inicio', pathMatch: 'full' },
];

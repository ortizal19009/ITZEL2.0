import { Routes } from '@angular/router';
import { AppWrapperComponent } from './layout/app-wrapper/app-wrapper.component';
import { EstrfuncComponent } from './componentes/contabilidad/estrfunc/estrfunc.component';
import { AddEstrfucComponent } from './componentes/contabilidad/estrfunc/add-estrfuc/add-estrfuc.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  { path: 'estrfunc', component: EstrfuncComponent },
  { path: 'add-estrfunc', component: AddEstrfucComponent },
  { path: '', redirectTo: 'inicio', pathMatch: 'full' },
];

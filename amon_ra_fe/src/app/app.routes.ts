import { Routes } from '@angular/router';
import { AppWrapperComponent } from './layout/app-wrapper/app-wrapper.component';
import { ProyectosComponent } from './componentes/contabilidad/proyectos/proyectos.component';
import { AddProyectoComponent } from './componentes/contabilidad/proyectos/add-proyecto/add-proyecto.component';
import { ModiProyectoComponent } from './componentes/contabilidad/proyectos/modi-proyecto/modi-proyecto.component';
import { ImpProyectoComponent } from './componentes/contabilidad/proyectos/imp-proyecto/imp-proyecto.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  { path: 'proyectos', component: ProyectosComponent },
  { path: 'add-proyecto', component: AddProyectoComponent },
  { path: 'modi-proyecto/:idproyecto', component: ModiProyectoComponent },
  { path: 'imp-proyecto', component: ImpProyectoComponent},
  { path: '', redirectTo: 'inicio', pathMatch: 'full' },
];

import { Routes } from '@angular/router';
import { ProyectosComponent } from './componentes/contabilidad/proyectos/proyectos.component';
import { AddProyectoComponent } from './componentes/contabilidad/proyectos/add-proyecto/add-proyecto.component';
import { ModiProyectoComponent } from './componentes/contabilidad/proyectos/modi-proyecto/modi-proyecto.component';
import { ImpProyectoComponent } from './componentes/contabilidad/proyectos/imp-proyecto/imp-proyecto.component';
import { AppWrapperComponent } from './layout/app-wrapper/app-wrapper.component';
import { IfinanComponent } from './componentes/contabilidad/ifinan/ifinan.component';
import { CuentasComponent } from './componentes/contabilidad/cuentas/cuentas.component';
import { AddCuentaComponent } from './componentes/contabilidad/cuentas/add-cuenta/add-cuenta.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  { path: 'proyectos', component: ProyectosComponent },
  { path: 'add-proyecto', component: AddProyectoComponent },
  { path: 'modi-proyecto/:idproyecto', component: ModiProyectoComponent },
  { path: 'imp-proyecto', component: ImpProyectoComponent },
  { path: 'ifinan', component: IfinanComponent },
  { path: 'cuentas', component: CuentasComponent },
  { path: 'add-cuenta/:idcuenta', component: AddCuentaComponent },
  { path: '', redirectTo: 'inicio', pathMatch: 'full' },
];

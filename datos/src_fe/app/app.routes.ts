import { Routes } from '@angular/router';
import { ProyectosComponent } from './componentes/contabilidad/proyectos/proyectos.component';
import { AddProyectoComponent } from './componentes/contabilidad/proyectos/add-proyecto/add-proyecto.component';
import { ModiProyectoComponent } from './componentes/contabilidad/proyectos/modi-proyecto/modi-proyecto.component';
import { ImpProyectoComponent } from './componentes/contabilidad/proyectos/imp-proyecto/imp-proyecto.component';
import { AppWrapperComponent } from './layout/app-wrapper/app-wrapper.component';
import { IfinanComponent } from './componentes/contabilidad/ifinan/ifinan.component';
import { CuentasComponent } from './componentes/contabilidad/cuentas/cuentas.component';
import { AddCuentaComponent } from './componentes/contabilidad/cuentas/add-cuenta/add-cuenta.component';
import { AddIfinanComponent } from './componentes/contabilidad/ifinan/add-ifinan/add-ifinan.component';
import { ModiIfinanComponent } from './componentes/contabilidad/ifinan/modi-ifinan/modi-ifinan.component';
import { IngresosComponent } from './componentes/contabilidad/presupuesto/ingresos/ingresos.component';
import { GastosComponent } from './componentes/contabilidad/presupuesto/gastos/gastos.component';
import { AddPingresoComponent } from './componentes/contabilidad/presupuesto/ingresos/add-pingreso/add-pingreso.component';
import { AddPgastoComponent } from './componentes/contabilidad/presupuesto/gastos/add-pgasto/add-pgasto.component';
import { ModiPingresoComponent } from './componentes/contabilidad/presupuesto/ingresos/modi-pingreso/modi-pingreso.component';
import { ModiPgastoComponent } from './componentes/contabilidad/presupuesto/gastos/modi-pgasto/modi-pgasto.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  { path: 'proyectos', component: ProyectosComponent },
  { path: 'add-proyecto', component: AddProyectoComponent },
  { path: 'modi-proyecto/:idproyecto', component: ModiProyectoComponent },
  { path: 'imp-proyecto', component: ImpProyectoComponent },
  { path: 'ifinan', component: IfinanComponent },
  { path: 'add-ifinan', component: AddIfinanComponent },
  { path: 'modi-ifinan/:idifinan', component: ModiIfinanComponent },
  { path: 'cuentas', component: CuentasComponent },
  { path: 'add-cuenta/:idcuenta', component: AddCuentaComponent },
  { path: 'pingresos', component: IngresosComponent },
  { path: 'pgastos', component: GastosComponent },
  { path: 'add-pingresos', component: AddPingresoComponent },
  { path: 'add-pgastos', component: AddPgastoComponent },
  { path: 'modi-pingresos/:idpresupuesto', component: ModiPingresoComponent },
  { path: 'modi-pgasto/:idpresupuesto', component: ModiPgastoComponent },
  { path: '', redirectTo: 'inicio', pathMatch: 'full' }
];

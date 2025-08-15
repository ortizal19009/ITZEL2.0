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
import { InfoProyectoComponent } from './componentes/contabilidad/proyectos/info-proyecto/info-proyecto.component';
import { InfoPgastoComponent } from './componentes/contabilidad/presupuesto/gastos/info-pgasto/info-pgasto.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  /* ==========PROYECTOS========== */
  { path: 'proyectos', component: ProyectosComponent },
  { path: 'add-proyecto', component: AddProyectoComponent },
  { path: 'modi-proyecto/:idproyecto', component: ModiProyectoComponent },
  { path: 'imp-proyecto', component: ImpProyectoComponent },
  { path: 'info-proyecto/:codigo', component: InfoProyectoComponent },
  /* ==========IFINAN========== */
  { path: 'ifinan', component: IfinanComponent },
  { path: 'add-ifinan', component: AddIfinanComponent },
  { path: 'modi-ifinan/:idifinan', component: ModiIfinanComponent },
  /* ==========CUENTAS========== */
  { path: 'cuentas', component: CuentasComponent },
  { path: 'add-cuenta/:idcuenta', component: AddCuentaComponent },
  /* ==========PARTIDAS PRESUPUESTARIAS INGRESOS========== */
  { path: 'pingresos', component: IngresosComponent },
  { path: 'add-pingresos', component: AddPingresoComponent },
  { path: 'modi-pingresos/:idpresupuesto', component: ModiPingresoComponent },
  /* ==========PARTIDAS PRESUPUESTARIAS GASTOS========== */
  { path: 'pgastos', component: GastosComponent },
  { path: 'add-pgastos', component: AddPgastoComponent },
  { path: 'modi-pgasto/:idpresupuesto', component: ModiPgastoComponent },
  { path: 'info-pgasto/:idpresupuesto', component: InfoPgastoComponent },

  //{ path: '', redirectTo: 'inicio', pathMatch: 'full' },
  { path: '', redirectTo: '/proyectos', pathMatch: 'full' },
];

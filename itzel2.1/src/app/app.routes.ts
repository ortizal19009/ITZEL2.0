import { Routes } from '@angular/router';
import { Proyectos } from './componentes/contabilidad/proyectos/proyectos/proyectos';
import { AddProyecto } from './componentes/contabilidad/proyectos/add-proyecto/add-proyecto';
import { ModiProyecto } from './componentes/contabilidad/proyectos/modi-proyecto/modi-proyecto';
import { ImpProyecto } from './componentes/contabilidad/proyectos/imp-proyecto/imp-proyecto';
import { InfoProyecto } from './componentes/contabilidad/proyectos/info-proyecto/info-proyecto';
import { Ifinan } from './componentes/contabilidad/ifinan/ifinan/ifinan';
import { AddIfinan } from './componentes/contabilidad/ifinan/add-ifinan/add-ifinan';
import { ModiIfinan } from './componentes/contabilidad/ifinan/modi-ifinan/modi-ifinan';
import { Cuentas } from './componentes/contabilidad/cuentas/cuentas/cuentas';
import { AddCuenta } from './componentes/contabilidad/cuentas/add-cuenta/add-cuenta';
import { ModiCuenta } from './componentes/contabilidad/cuentas/modi-cuenta/modi-cuenta';
import { InfoCuenta } from './componentes/contabilidad/cuentas/info-cuenta/info-cuenta';
import { Ingresos } from './componentes/contabilidad/presupuestos/ingresos/ingresos/ingresos';
import { AddIngreso } from './componentes/contabilidad/presupuestos/ingresos/add-ingreso/add-ingreso';
import { ModiIngreso } from './componentes/contabilidad/presupuestos/ingresos/modi-ingreso/modi-ingreso';
import { AppWrapper } from './componentes/layout/app-wrapper/app-wrapper';
import { Gastos } from './componentes/contabilidad/presupuestos/gastos/gastos/gastos';
import { AddGasto } from './componentes/contabilidad/presupuestos/gastos/add-gasto/add-gasto';
import { ModiGasto } from './componentes/contabilidad/presupuestos/gastos/modi-gasto/modi-gasto';
import { InfoGasto } from './componentes/contabilidad/presupuestos/gastos/info-gasto/info-gasto';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapper },
  /* ==========PROYECTOS========== */
  { path: 'proyectos', component: Proyectos },
  { path: 'add-proyecto', component: AddProyecto },
  { path: 'modi-proyecto/:idproyecto', component: ModiProyecto },
  { path: 'imp-proyecto', component: ImpProyecto },
  { path: 'info-proyecto/:codigo', component: InfoProyecto },
  /* ==========IFINAN========== */
  { path: 'ifinan', component: Ifinan },
  { path: 'add-ifinan', component: AddIfinan },
  { path: 'modi-ifinan/:idifinan', component: ModiIfinan },
  /* ==========CUENTAS========== */
  { path: 'cuentas', component: Cuentas },
  { path: 'add-cuenta/:idcuenta', component: AddCuenta },
  { path: 'modi-cuenta/:idcuenta', component: ModiCuenta },
  { path: 'info-cuenta/:idcuenta', component: InfoCuenta },
  /* ==========PARTIDAS PRESUPUESTARIAS INGRESOS========== */
  { path: 'ingresos', component: Ingresos },
  { path: 'add-ingresos', component: AddIngreso },
  { path: 'modi-ingresos/:idpresupuesto', component: ModiIngreso },
  /* ==========PARTIDAS PRESUPUESTARIAS GASTOS========== */
  { path: 'gastos', component: Gastos },
  { path: 'add-gastos', component: AddGasto },
  { path: 'modi-gasto/:idpresupuesto', component: ModiGasto },
  { path: 'info-gasto/:idpresupuesto', component: InfoGasto },

  //{ path: '', redirectTo: 'inicio', pathMatch: 'full' },
  { path: '', redirectTo: '/proyectos', pathMatch: 'full' },
];

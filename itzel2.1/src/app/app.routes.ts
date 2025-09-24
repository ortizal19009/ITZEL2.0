import { Routes } from '@angular/router';
import { ProyectosComponent } from './componentes/contabilidad/proyectos/proyectos/proyectos.component';
import { AddProyectoComponent } from './componentes/contabilidad/proyectos/add-proyecto/add-proyecto.component';
import { ModiProyectoComponent } from './componentes/contabilidad/proyectos/modi-proyecto/modi-proyecto.component';
import { ImpProyectoComponent } from './componentes/contabilidad/proyectos/imp-proyecto/imp-proyecto.component';
import { InfoProyectoComponent } from './componentes/contabilidad/proyectos/info-proyecto/info-proyecto.component';
import { IfinanComponent } from './componentes/contabilidad/ifinan/ifinan/ifinan.component';
import { AddIfinanComponent } from './componentes/contabilidad/ifinan/add-ifinan/add-ifinan.component';
import { ModiIfinanComponent } from './componentes/contabilidad/ifinan/modi-ifinan/modi-ifinan.component';
import { Cuentas } from './componentes/contabilidad/cuentas/cuentas/cuentas';
import { AddCuenta } from './componentes/contabilidad/cuentas/add-cuenta/add-cuenta';
import { ModiCuenta } from './componentes/contabilidad/cuentas/modi-cuenta/modi-cuenta';
import { InfoCuenta } from './componentes/contabilidad/cuentas/info-cuenta/info-cuenta';
import { Ingresos } from './componentes/contabilidad/presupuestos/ingresos/ingresos/ingresos';
import { AddIngreso } from './componentes/contabilidad/presupuestos/ingresos/add-ingreso/add-ingreso';
import { ModiIngreso } from './componentes/contabilidad/presupuestos/ingresos/modi-ingreso/modi-ingreso';
import { AppWrapperComponent } from './componentes/layout/app-wrapper/app-wrapper.component';
import { GastosComponent } from './componentes/contabilidad/presupuestos/gastos/gastos/gastos.component';
import { AddGastoComponent } from './componentes/contabilidad/presupuestos/gastos/add-gasto/add-gasto.component';
import { ModiGasto } from './componentes/contabilidad/presupuestos/gastos/modi-gasto/modi-gasto';
import { InfoGastoComponent } from './componentes/contabilidad/presupuestos/gastos/info-gasto/info-gasto.component';
import { CargosComponent } from './componentes/rol/cargos/cargos/cargos.component';
import { ClasificadorComponent } from './componentes/contabilidad/clasificador/clasificador/clasificador.component';
import { AddClasificadorComponent } from './componentes/contabilidad/clasificador/add-clasificador/add-clasificador.component';
import { PreingresosComponent } from './componentes/contabilidad/presupuestos/preingresos/preingresos/preingresos.component';
import { AddPartidaingComponent } from './componentes/contabilidad/presupuestos/preingresos/add-partidaing/add-partidaing.component';
import { ReporteUpdateComponent } from './componentes/administracion/reportesjr/reporte-update/reporte-update.component';
import { ReportesjrComponent } from './componentes/administracion/reportesjr/reporte-viewer/reportesjr.component';
import { ReportesComponent } from './componentes/administracion/reportesjr/reportes/reportes.component';
import { DefinirComponent } from './componentes/administracion/definir/definir/definir.component';
import { CertificacionesComponent } from './componentes/contabilidad/certificaciones/certificaciones/certificaciones.component';
import { AddCertificacionComponent } from './componentes/contabilidad/certificaciones/add-certificacion/add-certificacion.component';
import { ModiCertificacionComponent } from './componentes/contabilidad/certificaciones/modi-certificacion/modi-certificacion.component';
import { ReintegrosComponent } from './componentes/contabilidad/reintegros/reintegros/reintegros.component';
import { AddReintegroComponent } from './componentes/contabilidad/reintegros/add-reintegro/add-reintegro.component';
import { ModiReintegroComponent } from './componentes/contabilidad/reintegros/modi-reintegro/modi-reintegro.component';
import { InfoReintegroComponent } from './componentes/contabilidad/reintegros/info-reintegro/info-reintegro.component';

export const routes: Routes = [
  { path: 'inicio', component: AppWrapperComponent },
  /* 
  ======================================================================
  MODULO DE CONTABILIDAD GUBERNAMENTAL
  ======================================================================
  */

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
  { path: 'cuentas', component: Cuentas },
  { path: 'add-cuenta/:idcuenta', component: AddCuenta },
  { path: 'modi-cuenta/:idcuenta', component: ModiCuenta },
  { path: 'info-cuenta/:idcuenta', component: InfoCuenta },
  /* ==========PARTIDAS PRESUPUESTARIAS INGRESOS========== */
  { path: 'ingresos', component: Ingresos },
  { path: 'add-ingresos', component: AddIngreso },
  { path: 'modi-ingresos/:idpresupuesto', component: ModiIngreso },
  /* ==========PARTIDAS PRESUPUESTARIAS GASTOS========== */
  { path: 'gastos', component: GastosComponent },
  { path: 'add-gastos', component: AddGastoComponent },
  { path: 'modi-gasto/:idpresupuesto', component: ModiGasto },
  { path: 'info-gasto/:idpresupuesto', component: InfoGastoComponent },
  { path: 'preingresos', component: PreingresosComponent },
  { path: 'add-partidaing', component: AddPartidaingComponent },
  /* ==========CLASIFICADOR========== */
  { path: 'clasificador', component: ClasificadorComponent },
  { path: 'add-clasificador', component: AddClasificadorComponent },
  /* ==========CERTIFICACIONES========== */
  { path: 'certificaciones', component: CertificacionesComponent },
  { path: 'add-certificacion', component: AddCertificacionComponent },
  { path: 'modi-certificacion/:idcertificacion', component: ModiCertificacionComponent },
  /* ==========RE INTEGROS========== */
  { path: 'reintegros', component: ReintegrosComponent },
  { path: 'add-reintegro', component: AddReintegroComponent },
  { path: 'modi-reintegro/:idreintegro', component: ModiReintegroComponent },
  { path: 'info-reintegro/:idreintegro', component: InfoReintegroComponent },
  /* 
  ======================================================================
  MODULO ROLES
  ======================================================================
  */
  /* ==========CARGOS========== */
  { path: 'cargos', component: CargosComponent },
  /*
  ======================================================================
  ADMINISTRACIÓN CENTRAL
  ======================================================================
  */
  /* ==========JASPER REPORT========== */
  { path: 'reportesjr', component: ReportesComponent },
  { path: 'add-reporte', component: ReporteUpdateComponent },
  { path: 'viewRepot/:id', component: ReportesjrComponent },
  /* ==========DEFINIR========== */
  { path: 'definir', component: DefinirComponent },
  //{ path: '', redirectTo: 'inicio', pathMatch: 'full' },
  { path: '', redirectTo: '/proyectos', pathMatch: 'full' },
];

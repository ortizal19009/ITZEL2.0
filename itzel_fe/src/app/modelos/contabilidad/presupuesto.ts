import { Clasificador } from './clasificador';
import { Proyectos } from './proyectos';

export class Presupuesto {
  idpresupuesto?: number;
  tippar?: number;
  codpar?: string;
  codigo?: string;
  nompar?: string;
  inicia?: number;
  totmod?: number;
  totcerti?: number;
  totmisos?: number;
  totdeven?: number;
  arrastre?: number;
  arrastreaa?: number;
  idproyecto?: Proyectos;
  idclasificador?: Clasificador;
  usucrea?: number;
  feccrea?: Date;
  usumodi?: number;
  feccmodi?: Date;
}

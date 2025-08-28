import { Clasificador } from "./clasificador.model";
import { Proyecto } from "./proyecto.model";

export class Presupuesto {
  idpresupuesto?: number;
  tippar!: number;
  codpar!: string;
  codigo!: string;
  nompar!: string;
  inicia?: number;
  totmod?: number;
  totcerti?: number;
  totmisos?: number;
  totdeven?: number;
  arrastre?: number;
  arrastreaa?: number;
  proyecto?: Proyecto;
  clasificador?: Clasificador;
  usucrea?: number;
  feccrea?: Date;
  usumodi?: number;
  feccmodi?: Date;
}

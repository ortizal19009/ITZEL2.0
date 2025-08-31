import { Estructura } from "./estructura.model";

export class Proyecto {
  idproyecto?: number;
  codigo?: string;
  nombre?: string;
  movimiento?: boolean;
  estructura?: Estructura;
  usucrea?: number;
  feccrea?: Date;
  usumodi?: number;
  fecmodi?: Date;
}

import { Estructura } from "./estructura.model";

export class Proyectos {
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

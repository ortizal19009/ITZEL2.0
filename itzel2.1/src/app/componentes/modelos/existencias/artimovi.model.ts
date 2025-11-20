import { Articulos } from "./articulos.model";
import { Movimientos } from "./movimientos.model";

export class Artimovi {
  idartimovi?: number;
  tipmov?: number;
  cantidad?: number;
  costo?: number;
  total?: number;
  cosprom?: number;
  usucrea?: number;
  fechcrea?: Date;
  usumodi?: number;
  fechmodi?: Date;
  movimiento!: Movimientos;
  articulo!: Articulos;

}

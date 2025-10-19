import { Articulos } from './articulos.model';
import { Pedidos } from './pedidos.model';

export class Artixpedido {
  idartixpedido?: number;
  cantidad?: number;
  usucrea?: number;
  feccrea?: Date;
  usumodi?: number;
  fecmodi?: Date;
  articulo!: Articulos;
  pedido!: Pedidos;
}

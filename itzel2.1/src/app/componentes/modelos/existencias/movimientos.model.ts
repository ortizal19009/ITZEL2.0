import { Documentos } from '../administracion/documentos.model';
import { Beneficiarios } from '../contabilidad/beneficiarios.model';
import { Destinos } from './destinos.model';

export class Movimientos {
  idmovimiento?: number;
  tipmov!: number;
  numero!: number;
  fecha!: Date;
  numentrada!: number;
  total?: number;
  numart?: number;
  numdoc!: string;
  fecdoc?: Date;
  compegre?: string;
  swaprobado?: boolean;
  observaciones?: string;
  usucrea?: number;
  feccrea!: Date;
  usumodi?: number;
  fecmodi?: number;
  destino!: Destinos;
  beneficiario!: Beneficiarios;
  documento!: Documentos;
}

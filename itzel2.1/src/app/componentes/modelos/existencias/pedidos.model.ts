import { Documentos } from '../administracion/documentos.model';
import { Beneficiarios } from '../contabilidad/beneficiarios.model';
import { Destinos } from './destinos.model';

export class Pedidos {
  idpedido!: number;
  numero?: number;
  fecha?: Date;
  total?: number;
  descripcion?: string;
  usucrea!: number;
  feccrea!: Date;
  usumodi?: number;
  fecmodi?: Date;
  beneficiario?: Beneficiarios;
  destino?: Destinos;
  numdoc!: string;
  documento?: Documentos;
}

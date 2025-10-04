import { Documentos } from '../administracion/documentos.model';
import { Beneficiarios } from './beneficiarios.model';
import { Proyectos } from './proyectos.model';

export class Asientos {
  idasiento!: number;
  numero!: number;
  fecha!: Date;
  tipasi!: number;
  tipcom!: number;
  compro!: number;
  totdeb!: number;
  totcre!: number;
  numdoc!: string;
  concepto!: string;

  swretencion!: boolean;
  cerrado!: boolean;

  usucrea!: number;
  feccrea!: Date;
  usumodi?: number;
  fecmodi?: Date;

  documento!: Documentos;
  proyecto!: Proyectos;
  beneficiario!: Beneficiarios;
}

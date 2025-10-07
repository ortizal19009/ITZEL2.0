import { Documentos } from '../administracion/documentos.model';
import { Beneficiarios } from './beneficiarios.model';
import { Transacciones } from './transacciones.model';

export class Benextran {
  idbenxtra!: number;
  numdoc!: string;
  valor!: number;
  totpagcob!: number;
  pagocobro!: number;
  idpagocobro?: number;
  idpresupuesto?: number;
  codparreci?: string;
  codcuereci?: string;
  asierefe?: number;

  usucrea!: number;
  feccrea!: Date;
  usumodi?: number;
  fecmodi?: Date;

  transaccion!: Transacciones;
  beneficiario!: Beneficiarios;
  documento!: Documentos;
}

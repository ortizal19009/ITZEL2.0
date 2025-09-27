import { Documentos } from "../administracion/documentos.model";
import { Beneficiarios } from "./beneficiarios.model";

export class Certificaciones {
  idcertificacion?: number;
  tipo?: number;
  numero!: number;
  fecha?: Date; 
  valor?: number; 
  descripcion?: string; 
  numdoc?: string; 
  usucrea?: number; 
  feccrea?: Date; 
  usumodi?: number; 
  fecmodi?: Date; 
  beneficiario?: Beneficiarios; 
  beneficiariores?: Beneficiarios; 
  documento?: Documentos
}

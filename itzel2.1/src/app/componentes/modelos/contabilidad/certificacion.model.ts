import { Documentos } from "../administracion/documentos.model";
import { Beneficiario } from "./beneficiario.model";

export class Certificacion {
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
  beneficiario?: Beneficiario; 
  beneficiariores?: Beneficiario; 
  documento?: Documentos
}

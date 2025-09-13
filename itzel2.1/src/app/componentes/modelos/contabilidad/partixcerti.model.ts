import { Certificacion } from "./certificacion.model";
import { Ejecucion } from "./ejecucion.model";
import { Presupuesto } from "./presupuesto.model";

export class Partixcerti {
  idpartxcer?: number;
  valor?: number;
  reintegro?: number; 
  descripcion?: string; 
  totprmisos?: number;
  saldo?: number; 
  ejecucion?: Ejecucion; 
  usucrea?: number; 
  feccrea?: Date; 
  usumodi?: number; 
  fecmodi?: Date; 
  certificaion?: Certificacion;
  presupuesto?: Presupuesto;
}


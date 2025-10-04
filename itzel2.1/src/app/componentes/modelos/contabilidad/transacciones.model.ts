import { Documentos } from "../administracion/documentos.model";
import { Asientos } from "./asientos.model";
import { Beneficiarios } from "./beneficiarios.model";
import { Cuentas } from "./cuentas.model";

export class Transacciones {

   idtransaccion!: number;
   orden!: number;
   codcue!: string;
   valor!: number;
   debcre!: number;
   numdoc!: string;
   concepto!: string;
   tiptran!: number;
   codpar?: string;
   swconcili!: boolean;
   mesconcili?: number;
   totbene!: number;
   codpartr?: string;
   codcueiog?: string;
   debeiog?: number;
   haberiog?: number;
   asierefe?: number;
   idbanco?: number;
   tramite?: number;

   usucrea!: number;
   feccrea!: Date;
   usumodi?: number;
   fecmodi?: Date;

   asiento!: Asientos;
   cuenta!: Cuentas;
   beneficiario!: Beneficiarios;
   documento!: Documentos;

}

import { Gruposbene } from "./gruposbene.model";
import { Ifinan } from "./ifinan.model";

export class Beneficiarios {
  idbeneficiario!: number;
  codben?: string;
  nomben!: string;
  rucben?: string;
  ciben?: string;
  tlfben?: string;
  dirben?: string;
  emailben?: string;
  tpcuebank?: number;
  cuebank?: string;
  swconsufin?: boolean;
  foto?: string;
  tpidentifica? : number;
  grupo?: Gruposbene; 
  ifinan?: Ifinan;
  swmodulo1?: boolean; 
  swmodulo2?: boolean;
  swmodulo3?: boolean;
  swmodulo4?: boolean;
  swmodulo5?: boolean;
  usucrea?: number; 
  feccrea?: Date; 
  usumodi?: number; 
  fecmodi?: Date;
}

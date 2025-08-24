import { Gruposbene } from "./gruposbene";
import { Ifinan } from "./ifinan";

export class Beneficiarios {
  idbene?: number;
  codben?: string;
  nomben?: string;
  tipdben?: string;
  rucben?: string;
  ciben?: string;
  tlfben?: string;
  dirben?: string;
  mailben?: string;
  tpcueben?: number;
  cuebanben?: string;
  foto?: string;
  b1?: number; 
  b2?: number; 
  b3?: number;
  grupo?: Gruposbene; 
  ifinan?: Ifinan;
  modulo?: string; 
  usucrea?: number; 
  feccrea?: Date; 
  usumodi?: number; 
  fecmodi?: Date;
}

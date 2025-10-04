import { Niveles } from "./niveles.model";

export class Cuentas {
  idcuenta?: number;
  codcue?: string;
  nomcue?: string;
  movcue?: Boolean;
  nivel?: Niveles;
  grucue?: string;
  asodebe?: string;
  asohaber?: string;
  tiptran?: number;
  sigef?: Boolean;
  grubalances?: number;
  grufluefec?: number;
  resultcostos?: number;
  balancostos?: number;
  usucrea?: number;
  feccrea?: Date;
  usumodi?: number;
  fecmodi?: Date;
}

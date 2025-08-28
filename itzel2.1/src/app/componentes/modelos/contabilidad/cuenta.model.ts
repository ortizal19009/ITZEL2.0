import { Nivel } from "./nivel.model";

export class Cuenta {
  idcuenta?: number;
  codcue?: string;
  nomcue?: string;
  movcue?: Boolean;
  nivel?: Nivel;
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

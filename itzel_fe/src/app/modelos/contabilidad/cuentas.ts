import { Niveles } from './niveles';

export class Cuentas {
  idcuenta?: number;
  codcue?: string;
  nomcue?: string;
  movcue?: Boolean;
  idnivel?: Niveles;
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

import { Cuentas } from "../contabilidad/cuentas.model";

export class Articulos {

   idarticulo!: number;
   codigo!: string;
   nombre!: string;
   codcue!: string;
   unidad!: string;
   inicial!: number;
   cosinicial!: number;
   actual!: number;
   cosactual!: number;
   costotal!: number;
   descripcion!: string;
   minimo?: number;
   maximo?: number;
   swinmediato!: boolean;

   usucrea!: number;
   feccrea!: Date;
   usumodi?: number;
   fecmodi?: Date;

   cuenta!: Cuentas;
   
}

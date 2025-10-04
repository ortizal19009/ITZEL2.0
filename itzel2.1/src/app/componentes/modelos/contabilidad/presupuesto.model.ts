import { Clasificador } from "./clasificador.model";
import { Proyectos } from "./proyectos.model";

export class Presupuesto {

   idpresupuesto!: number;
   tippar!: number;
   codpar!: string;
   codigo!: string;
   nompar!: string;
   inicial!: number;
   totmod!: number;
   totcerti!: number;
   totmisos!: number;
   totdeven!: number;
   arrastre!: number;
   arrastreaa!: number;
   
   usucrea!: number;
   feccrea!: Date;
   usumodi?: number;
   feccmodi?: Date;

   proyecto!: Proyectos;
   clasificador!: Clasificador;
}

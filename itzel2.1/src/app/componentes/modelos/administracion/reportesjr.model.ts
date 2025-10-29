import { Repoxopcion } from "./repoxopcion.model";

export interface Reportesjr {
   idreporte?: number;
   nomrep?: string;
   desrep?: string;
   parametros?: string; // viene como JSON string desde backend
   repoxopcion?: Repoxopcion;
}

export interface ParametroReportejr {
   nombre: string;
   tipo?: string; // java.util.Date, java.lang.String, java.lang.Long, etc.
}
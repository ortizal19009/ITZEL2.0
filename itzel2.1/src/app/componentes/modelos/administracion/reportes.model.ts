export interface Reporte {
  idreporte?: number;
  nombre?: string;
  descripcion?: string;
  parametros?: string; // viene como JSON string desde backend
}

export interface ParametroReporte {
  nombre: string;
  tipo?: string; // java.util.Date, java.lang.String, java.lang.Long, etc.
}
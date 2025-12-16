import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Reportesjr } from '../../modelos/administracion/reportesjr.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from '../../../../environments/environment';
import { DatasetReportRequest } from '../../utileria/dataset-report-request';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/reportesjr`;

@Injectable({
  providedIn: 'root'
})

export class ReportesjrService {

  constructor(private http: HttpClient) { }

  // Buscar reportesjr por opcion, nombre y desrep ordenados por codigo
  getByOpcionNomrepyDesrep(codigo: String, nomrep: String, desrep: String) {
    return this.http.get<Reportesjr[]>(`${baseUrl}/busca?codigo=${codigo}&nomrep=${nomrep}&desrep=${desrep}`);
  }

  //Valida nomrep
  valNomrep(nomrep: string): Observable<boolean> {
    return this.http.get<boolean>(`${baseUrl}/valnomrep/${nomrep}`);
  }

  //Conteo por idrepoxopcion
  countPorRepoxopcion(idrepoxopcion: number): Observable<number> {
    return this.http.get<number>(`${baseUrl}/countidrepoxopcion/${idrepoxopcion}`);
  }

  // Buscar un reporte por su id
  getById(id: number): Observable<any> {
    return this.http.get<Reportesjr>(`${baseUrl}/${id}`);
  }

  // Buscar todos los reportes con un codigo específico
  obtenerPorCodigo(codigo: string): Observable<Reportesjr[]> {
    return this.http.get<Reportesjr[]>(`${baseUrl}/codigo/${codigo}`);
  }

  uploadReporte(idrepoxopcion: number, nomrep: string, metodo: number, desrep: string, jrxml: File, jasper: File): Observable<Reportesjr> {
    const formData = new FormData();
    formData.append('idrepoxopcion', idrepoxopcion.toString());
    formData.append('nomrep', nomrep);
    formData.append('metodo', metodo.toString());
    formData.append('desrep', desrep);
    formData.append('jrxml', jrxml);
    formData.append('jasper', jasper);

    return this.http.post<Reportesjr>(`${baseUrl}`, formData);
  }

  // Actualiza solo los metadatos del reporte (sin archivos)
  actualizarMetadatos(id: number, datos: { idrepoxopcion: number; nomrep: string; metodo: number; desrep: string }): Observable<Reportesjr> {
    const params = new HttpParams()
      .set('idrepoxopcion', datos.idrepoxopcion.toString())
      .set('nomrep', datos.nomrep)
      .set('metodo', datos.metodo)
      .set('desrep', datos.desrep);
    return this.http.put<Reportesjr>(`${baseUrl}/${id}/metadatos`, null, { params });
  }

  // Actualiza todos los datos del reporte, incluidos los archivos
  actualizarCompleto(id: number, datos: {
    idrepoxopcion: number;
    nomrep: string;
    metodo: number;
    desrep: string;
    jrxml: File;
    jasper: File;
  }): Observable<Reportesjr> {
    const formData = new FormData();
    formData.append('idrepoxopcion', datos.idrepoxopcion.toString());
    formData.append('nomrep', datos.nomrep);
    formData.append('metodo', datos.metodo.toString());
    formData.append('desrep', datos.desrep);
    formData.append('jrxml', datos.jrxml);
    formData.append('jasper', datos.jasper);

    return this.http.put<Reportesjr>(`${baseUrl}/${id}`, formData);
  }

  deleteReporte(id: number) {
    return this.http.delete(`${baseUrl}/${id}`);
  }

  //Elimina
  delete(idreportejr: number) {
    return this.http.delete(`${baseUrl}/${idreportejr}`);
  }

  // Reportes SQL Directo
  ejecutarReporteDB(dto: any): Observable<Blob> {
    return this.http.post(`${apiUrl}/reporteJasper/sql`, dto, { responseType: 'blob', });
  }

  // Reportes Coleccion de Beans (no se usa se llama desde cada opcion)
  // ejecutarReporteBean(dto: any): Observable<Blob> {
  //    return this.http.post(`${apiUrl}/reporteJasper/beans`, dto, { responseType: 'blob', });
  // }

  // Reportes Dataset desde el Frontend
  ejecutarReporteDataset(dto: DatasetReportRequest) {
    return this.http.post(`${apiUrl}/reporteJasper/dataset`, dto, { responseType: 'blob' });
  }

  // ejecutarReporteDataset(dto: DatasetReportRequest) {
  //    return this.http.post(`${apiUrl}/dataset`, dto, { responseType: 'blob' });
  // }

}

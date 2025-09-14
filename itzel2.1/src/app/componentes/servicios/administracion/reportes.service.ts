import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/reportesjr`;

@Injectable({
  providedIn: 'root',
})
export class ReportesService {
  constructor(private http: HttpClient) {}

  getReporte(id: number): Observable<any> {
    return this.http.get<any>(`${baseUrl}/${id}`);
  }

  uploadReporte(nombre: string, descripcion: string, jrxml: File, jasper: File): Observable<any> {
    const formData = new FormData();
    formData.append('nombre', nombre);
    formData.append('descripcion', descripcion);
    formData.append('jrxml', jrxml);
    formData.append('jasper', jasper);

    return this.http.post(`${baseUrl}`, formData);
  }

  getReportes(): Observable<any[]> {
    return this.http.get<any[]>(`${baseUrl}`);
  }

  ejecutarReporte(id: number, params: any): Observable<Blob> {
    return this.http.post(`${baseUrl}/${id}/ejecutar`, params, { responseType: 'blob' });
  }
  ejecutarReporteDB(dto: any): Observable<Blob> {
    return this.http.post(`http://localhost:8080/jasperReports/descargar`, dto, {
      responseType: 'blob',
    });
  }
  deleteReporte(id: number) {
    return this.http.delete(`${baseUrl}/${id}`);
  }
  getOneReporte(id: number) {
    return this.http.get(`${baseUrl}/${id}`);
  }
}

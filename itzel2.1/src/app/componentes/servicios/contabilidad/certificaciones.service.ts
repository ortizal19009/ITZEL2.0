import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Certificacion } from '../../modelos/contabilidad/certificacion.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/certificaciones`;
@Injectable({
  providedIn: 'root',
})
export class CertificacionesService {
  constructor(private http: HttpClient) {}
  //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
  getCertificacionesByTipo(tipo: number): Observable<Certificacion> {
    return this.http.get<Certificacion>(`${baseUrl}/tipo?tipo=${tipo}`);
  }
  saveCertificacion(certificacion: Certificacion) {
    return this.http.post(`${baseUrl}`, certificacion);
  }
  findLastByTipo(tipo: number): Observable<Certificacion> {
    return this.http.get<Certificacion>(`${baseUrl}/lastbytipo?tipo=${tipo}`);
  }
  getByNumDate(
    t: number,
    fd: Date,
    fh: Date,
    min: number,
    max: number
  ): Observable<Certificacion[]> {
    return this.http.get<Certificacion[]>(
      `${baseUrl}/findall?tipo=${t}&fechaInicio=${fd}&fechaFin${fh}&min=${min}&max=${max}`
    );
  }
}

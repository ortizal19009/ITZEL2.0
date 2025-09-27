import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Certificaciones } from '../../modelos/contabilidad/certificaciones.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/certificaciones`;
@Injectable({
  providedIn: 'root',
})
export class CertificacionesService {
  constructor(private http: HttpClient) {}
  //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
  getCertificacionesByTipo(tipo: number): Observable<Certificaciones> {
    return this.http.get<Certificaciones>(`${baseUrl}/tipo?tipo=${tipo}`);
  }
  saveCertificacion(certificacion: Certificaciones) {
    return this.http.post(`${baseUrl}`, certificacion);
  }
  findLastByTipo(tipo: number): Observable<Certificaciones> {
    return this.http.get<Certificaciones>(`${baseUrl}/lastbytipo?tipo=${tipo}`);
  }
  getByNumDate(
    t: number,
    fd: Date,
    fh: Date,
    min: number,
    max: number
  ): Observable<Certificaciones[]> {
    return this.http.get<Certificaciones[]>(
      `${baseUrl}/findall?tipo=${t}&fechaInicio=${fd}&fechaFin=${fh}&min=${min}&max=${max}`
    );
  }
  getByIdCertificacion(idcertificacion: number): Observable<Certificaciones> {
    return this.http.get<Certificaciones>(`${baseUrl}?idcertificacion=${idcertificacion}`);
  }
  isAvailable(tipo: number, numero: number): Observable<boolean> {
    console.log(tipo, numero);
    return this.http.get<boolean>(`${baseUrl}/available?tipo=${tipo}&numero=${numero}`);
  }
}

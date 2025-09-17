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
}

import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/ejecucion`;
@Injectable({
  providedIn: 'root',
})
export class EjecucionService {
  constructor(private http: HttpClient) {}
  countEjecucionPorPartida(idpresupuesto: any) {
    return this.http.get(`${baseUrl}/countporpartida?idpresupuesto=${idpresupuesto}}`);
  }
}

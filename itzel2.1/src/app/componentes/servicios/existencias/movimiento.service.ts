import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Movimientos } from '../../modelos/existencias/movimientos.model';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/movimientos`;
@Injectable({
  providedIn: 'root',
})
export class MovimientoService {
  constructor(private http: HttpClient) {}
  saveMovimiento(movimiento: Movimientos): Observable<Movimientos> {
    return this.http.post<Movimientos>(`${baseUrl}`, movimiento);
  }
  findByTipMovimiento(tipmov: number): Observable<Movimientos> {
    return this.http.get<Movimientos>(`${baseUrl}/tipmov?tipmov=${tipmov}`);
  }
}

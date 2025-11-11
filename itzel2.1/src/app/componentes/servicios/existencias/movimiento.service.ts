import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Movimientos } from '../../modelos/existencias/movimientos.model';
import { firstValueFrom, Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/movimientos`;
@Injectable({
  providedIn: 'root',
})
export class MovimientoService {
  constructor(private http: HttpClient) { }
  saveMovimiento(movimiento: Movimientos): Observable<Movimientos> {
    return this.http.post<Movimientos>(`${baseUrl}`, movimiento);
  }
  findByTipMovimiento(tipmov: number): Observable<Movimientos[]> {
    return this.http.get<Movimientos[]>(`${baseUrl}/tipmov?tipmov=${tipmov}`);
  }
  findUltimo(tipmov: number): Observable<number> {
    return this.http.get<number>(`${baseUrl}/last?tipmov=${tipmov}`);
  }
  getNumAvailable(tipmov: number, numero: number): Observable<boolean> {
    return this.http.get<boolean>(`${baseUrl}/exist?tipmov=${tipmov}&numero=${numero}`);
  }
  getAllMovimientos(): Observable<Movimientos[]> {
    return this.http.get<Movimientos[]>(`${baseUrl}`);
  }
  getMovimientoById(id: number): Observable<Movimientos> {
    return this.http.get<Movimientos>(`${baseUrl}/${id}`);
  }
  updateMovimiento(movimiento: Movimientos): Observable<Movimientos> {
    return this.http.put<Movimientos>(`${baseUrl}`, movimiento);
  }
  getMovByTipMovAndNombene(tipmov: number, nombene: string): Observable<Movimientos[]> {
    return this.http.get<Movimientos[]>(`${baseUrl}/tipmov-nombene?tipmov=${tipmov}&nombene=${nombene}`);
  }
}

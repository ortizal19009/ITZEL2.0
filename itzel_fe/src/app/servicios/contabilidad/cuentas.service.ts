import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom, Observable } from 'rxjs';
import { Cuentas } from '../../modelos/contabilidad/cuentas';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/cuentas`;
@Injectable({
  providedIn: 'root',
})
export class CuentasService {
  constructor(private http: HttpClient) {}
  getAllCuentas() {
    return this.http.get(`${baseUrl}`);
  }
  getByPagesCuentas(page: number, size: number) {
    return this.http.get(`${baseUrl}/byPages?page=${page}&size=${size}`);
  }
  getByCodOrNom(cod: any, nom: any, page: number, size: number) {
    if (cod === '') cod = null;
    if (nom === '') nom = null;
    return this.http.get(
      `${baseUrl}/bycodOrnom?codcue=${cod}&nomcue=${nom}&page=${page}&size=${size}`
    );
  }
  getByIdCuenta(idcuenta: number) {
    return this.http.get(`${baseUrl}/byId?idcuenta=${idcuenta}`);
  }
  saveCuenta(cuenta: number) {
    return this.http.post(`${baseUrl}`, cuenta);
  }
  //buscar una sola cuenta por el codigo cuenta (codcue)
  getCuentaByCodcue(codcue: string): Observable<Cuentas> {
    return this.http.get(`${baseUrl}/byCodcue?codcue=${codcue}`);
  }
  async asyncgetCuentaByCodcue(codcue: string): Promise<Cuentas> {
    return firstValueFrom(
      this.http.get(`${baseUrl}/byCodcue?codcue=${codcue}`)
    );
  }
  updateCuenta(cuenta: Cuentas) {
    return this.http.put(`${baseUrl}`, cuenta);
  }
}

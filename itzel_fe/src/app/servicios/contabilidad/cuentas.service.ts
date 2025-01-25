import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
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
  saveCuenta(cuenta: number) {
    return this.http.post(`${baseUrl}`, cuenta);
  }
}

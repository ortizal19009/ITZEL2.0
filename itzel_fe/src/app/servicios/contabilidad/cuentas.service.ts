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
  saveCuenta(cuenta: number) {
    return this.http.post(`${baseUrl}`, cuenta);
  }
}

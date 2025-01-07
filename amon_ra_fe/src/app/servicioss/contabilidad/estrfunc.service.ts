import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/estrfunc`;
@Injectable({
  providedIn: 'root',
})
export class EstrfuncService {
  constructor(private http: HttpClient) {}
  estrfuncGetAll() {
    return this.http.get(`${baseUrl}`);
  }
  validarCodigo(codigo: string) {
    return this.http.get(`${baseUrl}/validar/codigo?codigo=${codigo}`);
  }
  validarNombre(nombre: string) {
    return this.http.get(`${baseUrl}/validar/nombre?nombre=${nombre}`);
  }
  estrfuncSave(estfunc: any) {
    return this.http.post(`${baseUrl}`, estfunc);
  }
}

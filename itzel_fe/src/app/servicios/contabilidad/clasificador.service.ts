import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/clasificador`;
@Injectable({
  providedIn: 'root',
})
export class ClasificadorService {
  constructor(private http: HttpClient) {}
  getAllClasificador() {
    return this.http.get(`${baseUrl}`);
  }
  getAllClasificadorByCodNom(dato: string) {
    return this.http.get(`${baseUrl}/codnompar?dato=${dato}`);
  }
}

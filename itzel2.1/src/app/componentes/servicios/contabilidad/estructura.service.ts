import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Estructura } from '../../modelos/contabilidad/estructura.model';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/estructura`;
@Injectable({
  providedIn: 'root',
})
export class EstructuraService {
  constructor(private http: HttpClient) {}
  // Devuelve todas las estructuras
  estructuraGetAll() {
    return this.http.get<Estructura>(`${baseUrl}`);
  }
  // Devuelve la entidad con el nivel más alto
  findTopByOrderByNivelDesc() {
    return this.http.get<Estructura>(`${baseUrl}/maxnivel`);
  }
  // Devuelve todas las entidades con un nivel específico
  findByNivel(nivel: number) {
    return this.http.get<Estructura>(`${baseUrl}/findByNivel?nivel=${nivel}`);
  }
}

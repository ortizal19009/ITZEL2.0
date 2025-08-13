import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/proyectos`;
@Injectable({
  providedIn: 'root',
})
export class ProyectosService {
  constructor(private http: HttpClient) {}
  proyectosGetAll() {
    return this.http.get(`${baseUrl}`);
  }

  validarCodigo(codigo: string) {
    return this.http.get(`${baseUrl}/validar/codigo?codigo=${codigo}`);
  }
  validarNombre(nombre: string) {
    return this.http.get(`${baseUrl}/validar/nombre?nombre=${nombre}`);
  }
  proyectoSave(proyecto: any) {
    return this.http.post(`${baseUrl}`, proyecto);
  }
  proyectoGetById(idproyecto: number) {
    return this.http.get(`${baseUrl}/${idproyecto}`);
  }
  proyectosUpdate(proyecto: any) {
    return this.http.put(
      `${baseUrl}?idproyecto=${proyecto.idproyecto}`,
      proyecto
    );
  }
  proyectoDelete(idproyecto: number) {
    return this.http.delete(`${baseUrl}/${idproyecto}`);
  }
  getProyectosByNivel(nivel: number) {
    return this.http.get(`${baseUrl}/reportes/porniveles?nivel=${nivel}`);
  }
  getProyectosByGrupo(codigo: string) {
    return this.http.get(`${baseUrl}/reportes/porgrupo?codigo=${codigo}`);
  }
  getByCodNom(dato: string) {
    return this.http.get(`${baseUrl}/codnom?dato=${dato}`);
  }
  getByCodigoLike(codigo: string) {
    return this.http.get(`${baseUrl}/proyectosLike?codigo=${codigo}`);
  }
  /* OBTENER REPORTES JASPERREPORT */
  getAllProyectosReport(): Observable<Blob> {
    return this.http.get(`${baseUrl}/reportes/proyectos/findall`, {
      responseType: 'blob',
    });
  }
  getByNivelProyectosReport(nivel: number): Observable<Blob> {
    return this.http.get(
      `${baseUrl}/reportes/proyectos/bynivel?nivel=${nivel}`,
      {
        responseType: 'blob',
      }
    );
  }
  getCogigoProyectosReport(codigo: string): Observable<Blob> {
    return this.http.get(
      `${baseUrl}/reportes/proyectos/bycodigo?codigo=${codigo}`,
      {
        responseType: 'blob',
      }
    );
  }
}

import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Clasificador } from '../../modelos/contabilidad/clasificador.model';
import { Observable } from 'rxjs';


const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/clasificador`;

@Injectable({
  providedIn: 'root'
})

export class ClasificadorService {

  constructor(private http: HttpClient) { }

  getAllClasificador() {
    return this.http.get(`${baseUrl}`);
  }
  getAllClasificadorByCodNom(dato: string) {
    return this.http.get(`${baseUrl}/codnompar?dato=${dato}`);
  }

  //Busca las partidas del clasificador codpar y nompar
  getByCodparyNompar(codpar: String, nompar: String) {
    return this.http.get<Clasificador[]>(`${baseUrl}/busca?codpar=${codpar}&nompar=${nompar}`);
  }

  //Valida codpar
  valCodpar(codpar: string): Observable<boolean> {
    const url = `${baseUrl}/valcodpar/${encodeURIComponent(codpar)}`;
    return this.http.get<boolean>(url);
  }

  //Valida nompar
  valNompar(nompar: string): Observable<boolean> {
    const url = `${baseUrl}/valnompar/${encodeURIComponent(nompar)}`;
    return this.http.get<boolean>(url);
  }

  //Partidas del clasificador por codpar para datalist
  findPartidasing(codpar: string) {
    // console.log(`${baseUrl}/partidasing?codpar=${codpar}`)
    return this.http.get<Clasificador[]>(`${baseUrl}/partidasing?codpar=${codpar}`);
  }

  //Guarda nuevo
  save(partida: Clasificador): Observable<Object> {
    return this.http.post(baseUrl, partida);
  }

  //Busca por idclasificador
  getByIdclasificador(idclasificador: number) {
    return this.http.get<Clasificador>(baseUrl + "/" + idclasificador);
  }

  //Modifica
  update(idclasificador: number, partida: Clasificador): Observable<Object> {
    return this.http.put(baseUrl + "/" + idclasificador, partida);
  }

  //Elimina
  delete(idclasificador: number) {
    return this.http.delete(`${baseUrl}/${idclasificador}`);
  }

}
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Destinos } from '../../modelos/existencias/destinos.model';
import { Observable } from 'rxjs';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/destinos`;

@Injectable({
   providedIn: 'root'
})

export class DestinosService {

   constructor(private http: HttpClient) { }

   //Obtiene todas las Destinos ordenadas por nomdestino
   getListaDestinos(): Observable<Destinos[]> {
      return this.http.get<Destinos[]>(baseUrl);
   }

   //Valida nomdestino
   valNomdest(nomdestino: string): Observable<boolean> {
      return this.http.get<boolean>(`${baseUrl}/valnomdestino/${encodeURIComponent(nomdestino)}`);
   }

   //Guardar nuevo
   save(destino: Destinos): Observable<Object> {
      return this.http.post(baseUrl, destino);
   }

   //Buscar por id
   getByIddestino(iddestino: number) {
      return this.http.get<Destinos>(baseUrl + "/" + iddestino);
   }

   //Modificar
   update(iddestino: number, destino: Destinos): Observable<Object> {
      return this.http.put(baseUrl + "/" + iddestino, destino);
   }

   //Eliminar
   delete(iddestino: number) {
      return this.http.delete(`${baseUrl}/${iddestino}`);
   }
   
}

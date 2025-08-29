import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Cargos } from '../../modelos/rol/cargos.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/cargos`;
@Injectable({
  providedIn: 'root'
})
export class CargosService {
   constructor(private http: HttpClient) { }

   //Obtiene todos los Cargos ordenadas por nomcargo
   getListaCargos(): Observable<Cargos[]> {
      return this.http.get<Cargos[]>(baseUrl);
   }

   //Valida nomcargo
   valNomcargo(nomcargo: string): Observable<boolean> {
      return this.http.get<boolean>(`${baseUrl}/valnomcargo/${encodeURIComponent(nomcargo)}`);
   }

   //Guardar nuevo
   save(cargo: Cargos): Observable<Object> {
      return this.http.post(baseUrl, cargo);
   }

   //Buscar por id
   getByIdcargo(idcargo: number) {
      return this.http.get<Cargos>(baseUrl + "/" + idcargo);
   }

   //Modificar
   update(idcargo: number, cargo: Cargos): Observable<Object> {
      return this.http.put(baseUrl + "/" + idcargo, cargo);
   }

   //Eliminar
   delete(idcargo: number) {
      return this.http.delete(`${baseUrl}/${idcargo}`);
   }
}

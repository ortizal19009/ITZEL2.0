import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { Observable } from 'rxjs';
import { Ifinan } from '../../modelos/contabilidad/ifinan';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/ifinan`;
@Injectable({
  providedIn: 'root',
})
export class IfinanService {
  constructor(private http: HttpClient) {}
  //Instituciones financieras: todas ordendas por nomifinan (con sort)
  getListaIfinans(): Observable<Ifinan[]> {
    return this.http.get<Ifinan[]>(`${baseUrl}/getall`);
  }

  valNomifinan(nomifinan: string): Observable<boolean> {
    return this.http.get<boolean>(
      `${baseUrl}/valNomifinan?nomifinan=${nomifinan}`
    );
  }

  valCodifinan(codifinan: string): Observable<boolean> {
    return this.http.get<boolean>(
      `${baseUrl}/valCodifinan?codifinan=${codifinan}`
    );
  }

  saveIfinancieras(finan: Ifinan): Observable<Object> {
    return this.http.post(baseUrl, finan);
  }

  deleteIfinan(idifinan: number): Observable<Object> {
    return this.http.delete(`${baseUrl}/${idifinan}`);
  }

  getById(idifinan: number) {
    return this.http.get<Ifinan>(baseUrl + '/' + idifinan);
  }
  update(id: number, ifinan: Ifinan): Observable<Object> {
    return this.http.put(baseUrl + '/' + id, ifinan);
  }
  getIfinanByDescripcion(descripcion: String) {
    return this.http.get<Ifinan[]>('${baseUrl}?nomifinan=${nomifinan}');
  }
}

import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Eliminados } from '../../modelos/administracion/eliminados.model';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/eliminados`;
@Injectable({
  providedIn: 'root',
})
export class EliminadosService {
  constructor(private http: HttpClient) {}

  save(eliminado: Eliminados): Observable<Object> {
    return this.http.post(baseUrl, eliminado);
  }


}

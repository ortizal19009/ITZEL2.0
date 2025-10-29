import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Observable } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/repoxopcion`;
@Injectable({
  providedIn: 'root',
})
export class RepoxopcionService {
  constructor(private http: HttpClient) {}
  obtenerPorCodigo(dato: any):Observable<any> {
    return this.http.get<any>(`${baseUrl}`);
  }
}

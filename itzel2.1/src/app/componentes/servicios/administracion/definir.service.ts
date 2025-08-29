import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom, lastValueFrom, Observable } from 'rxjs';
import { Definir } from '../../modelos/administracion/definir.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/definir`;
@Injectable({
  providedIn: 'root'
})
export class DefinirService {
    constructor(private http: HttpClient) { }

  getByIddefinir(iddefinir: number) {
    return this.http.get<Definir>(baseUrl + '/' + iddefinir);
  }

  async getByIddefinirAsync(iddefinir: number): Promise<Definir> {
    const source$ = this.http.get<Definir>(baseUrl + '/' + iddefinir);
    return lastValueFrom(source$);
  }


  updateDefinir(iddefinir: number, definir: Definir): Observable<Object> {
    return this.http.put(baseUrl + '/' + iddefinir, definir);
  }
  upFirma(iddefinir: number, formData: any) {
    return firstValueFrom(this.http.put(`${baseUrl}/subir-firma/${iddefinir}`, formData));
  }
}

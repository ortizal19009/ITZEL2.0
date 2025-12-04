import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/artimovi`;
@Injectable({
  providedIn: 'root'
})
export class ArtimoviService {
  constructor(private http: HttpClient) { }

  saveArtimovi(artimovi: any) {
    return this.http.post(`${baseUrl}/guardar-artimovi`, artimovi);
  }
  getByIdMovimiento(idmovimiento: number) {
    return this.http.get<any>(`${baseUrl}/by-movimiento?idmovimiento=${idmovimiento}`);
  }
  async saveArtimoviAsync(artimovi: any): Promise<any> {
    console.log(artimovi);
    return firstValueFrom(this.http.post<any>(`${baseUrl}/guardar-artimovi`, artimovi));
  }

}

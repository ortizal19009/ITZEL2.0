import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/presupuesto`;
@Injectable({
  providedIn: 'root',
})
export class PresupuestoService {
  constructor(private http: HttpClient) {}
  async getAllPresupuestoPageable(page: number, size: number): Promise<any[]> {
    let presupuestos = await firstValueFrom(
      this.http.get<any[]>(`${baseUrl}?page=${page}&size=${size}`)
    );
    return presupuestos;
  }
  async getPresupuestoTipparP(
    tippar: number,
    page: number,
    size: number
  ): Promise<any[]> {
    let presupuestos = await firstValueFrom(
      this.http.get<any[]>(
        `${baseUrl}/tippar?tippar=${tippar}&page=${page}&size=${size}`
      )
    );
    return presupuestos;
  }
  async getByParDenom(
    dato: string,
    tippar: number,
    page: number,
    size: number
  ): Promise<any[]> {
    let presupuestos = await firstValueFrom(
      this.http.get<any[]>(
        `${baseUrl}/codnom?dato=${dato}&tippar=${tippar}&page=${page}&size=${size}`
      )
    );
    return presupuestos;
  }
  savePresupuesto(presupuesto: any) {
    return this.http.post(`${baseUrl}`, presupuesto);
  }
  findById(idpresupuesto: number) {
    return this.http.get(`${baseUrl}/byId?idpresupuesto=${idpresupuesto}`);
  }
  getByCodigoProyectoLike(codigo: string) {
    return this.http.get(`${baseUrl}/presupuestosLike?codigo=${codigo}`);
  }
  findTipparAndCodpar(tippar: number, codpar: string) {
    return this.http.get(`${baseUrl}/debhab?tippar=${tippar}&codpar=${codpar}`);
  }
}

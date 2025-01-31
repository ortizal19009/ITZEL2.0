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
}

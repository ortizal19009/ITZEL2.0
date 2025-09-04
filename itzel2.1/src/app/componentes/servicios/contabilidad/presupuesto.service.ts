import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom, Observable } from 'rxjs';
import { Presupuesto } from '../../modelos/contabilidad/presupuesto.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/presupuesto`;
@Injectable({
  providedIn: 'root'
})
export class PresupuestoService {
  constructor(private http: HttpClient) { }
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
  /* ConsultasIngCadena */
  //Busca las partidas de ingresos codpar y nompar
  getByCodparyNompar(tippar: number, codpar: String, nompar: String) {
    return this.http.get<Presupuesto[]>(`${baseUrl}/busca?tippar=${tippar}&codpar=${codpar}&nompar=${nompar}`);
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

  //Cuenta en Presupuesto las Partidas del clasificador por idclasificador
  countPresupuestoPorClasificador(idclasificador: number): Observable<number> {
    return this.http.get<number>(`${baseUrl}/countidclasificador/${idclasificador}`);
  }

  //Guarda nuevo
  save(partida: Presupuesto): Observable<Object> {
    return this.http.post(baseUrl, partida);
  }

  //Busca por idpresupuesto
  getByIdpresupuesto(idpresupuesto: number) {
    return this.http.get<Presupuesto>(baseUrl + "/" + idpresupuesto);
  }

  //Elimina
  delete(idpresupuesto: number) {
    return this.http.delete(`${baseUrl}/${idpresupuesto}`);
  }
}

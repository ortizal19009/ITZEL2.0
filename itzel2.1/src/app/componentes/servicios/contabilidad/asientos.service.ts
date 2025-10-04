import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Asientos } from '../../modelos/contabilidad/asientos.model';
import { Observable } from 'rxjs';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/asientos`;

@Injectable({
   providedIn: 'root'
})

export class AsientosService {

   constructor(private http: HttpClient) { }

   //Busca asientos desde/hasta por número y fecha
   buscaByNumeroYFecha(desdeNum: number, hastaNum: number, desdeFecha: Date, hastaFecha: Date) {
      return this.http.get<Asientos[]>(`${baseUrl}/busca?desdeNum=${desdeNum}&hastaNum=${hastaNum}&desdeFecha=${desdeFecha}&hastaFecha=${hastaFecha}`);
   }

   //Ultimo número de asiento
   ultimo(): Observable<number> {
      return this.http.get<number>(`${baseUrl}/ultimo`);
   }

   //Ultimo Comprobante
   obtenerUltimoCompro(tipcom: number): Observable<number> {
      return this.http.get<number>(`${baseUrl}/ultimocompro?tipcom=${tipcom}`);
   }

   //Comprobantes por numero y fecha
   getComprobantes(asi_com: number, tipcom: number, desdeNum: number, hastaNum: number, desdeFecha: Date, hastaFecha: Date): Observable<Asientos[]> {
      return this.http.get<Asientos[]>(`${baseUrl}?asi_com=${asi_com}&tipcom=${tipcom}&desdeNum=${desdeNum}&hastaNum=${hastaNum}&desdeFecha=${desdeFecha}&hastaFecha=${hastaFecha}`);
   }

   //Ultima Fecha
   obtenerUltimaFecha(): Observable<Date> {
      return this.http.get<Date>(`${baseUrl}/ultimafecha`);
   }

   //Siguiente número de asiento
   siguienteNumero(): Observable<number> {
      return this.http.get<number>(`${baseUrl}/siguiente`);
   }

   //Valida número de Comprobante
   valCompro(tipcom: number, compro: number): Observable<boolean> {
      return this.http.get<boolean>(`${baseUrl}/valcompro?tipcom=${tipcom}&compro=${compro}`);
   }

   //Nuevo
   saveAsiento(asientos: Asientos): Observable<Object> {
      return this.http.post(`${baseUrl}`, asientos);
   }

   // Asiento por idasiento
   obtenerPorIdasiento(idasiento: number): Observable<Asientos> {
      return this.http.get<Asientos>(`${baseUrl}/${idasiento}`);
   }

   //Actualiza totales
   updateTotdebAndTotcre(idasiento: number, totdeb: number, totcre: number): Observable<any> {
      return this.http.patch(`${baseUrl}/totales?idasiento=${idasiento}&totdeb=${totdeb}&totcre=${totcre}`, null);
   }
}

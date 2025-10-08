import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom, Observable } from 'rxjs';
import { Transacciones } from '../../modelos/contabilidad/transacciones.model';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/transacciones`;

@Injectable({
  providedIn: 'root',
})
export class TransaccionesService {
  constructor(private http: HttpClient) {}

  //Transaccion por idasiento
  obtenerPorIdAsiento(idasiento: number): Observable<Transacciones[]> {
    return this.http.get<Transacciones[]>(`${baseUrl}/busca/${idasiento}`);
  }

  //Verifica si una Cuenta tiene Transacciones
  tieneTransaci(codcue: string): Observable<boolean> {
    return this.http.get<boolean>(`${baseUrl}/tieneTransaci?codcue=${codcue}`);
  }

  //Temporal
  countTransaccionesPorCodcue(codcue: String): Observable<number> {
    return new Observable<number>((observer) => {
      observer.next(3);
      observer.complete();
    });
  }

  //Verifica si una Cuenta tiene Transacciones Async
  async tieneTransaciAsync(codcue: string): Promise<any> {
    const response = await firstValueFrom(
      this.http.get<any>(`${baseUrl}/tieneTransaci?codcue=${codcue}`)
    );
    return response;
  }

  //Guarda
  saveTransa(transa: Transacciones): Observable<Object> {
    return this.http.post(baseUrl, transa);
  }

  //Busca por idtransaccion
  getById(idtransaccion: number) {
    return this.http.get<Transacciones>(`${baseUrl}/${idtransaccion}`);
  }

  //Actualiza
  updateTransaccion(idtransaccion: number, transaccion: Transacciones): Observable<Object> {
    return this.http.put(baseUrl + '/' + idtransaccion, transaccion);
  }
  deleteTransaccion(idtransaccion: number): Observable<Object> {
    return this.http.delete(`${baseUrl}/${idtransaccion}`);
  }
}

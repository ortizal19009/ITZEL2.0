import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Artixpedido } from '../../modelos/existencias/artixpedido.model';
import { catchError, firstValueFrom, Observable, throwError } from 'rxjs';
import { Articulos } from '../../modelos/existencias/articulos.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/artixpedido`;
@Injectable({
  providedIn: 'root',
})
export class ArtixpedidoService {
  constructor(private http: HttpClient) {}
  //Guardar nuevo
  async save(artixpedido: Artixpedido): Promise<Artixpedido> {
    return firstValueFrom(this.http.post<Artixpedido>(`${baseUrl}`, artixpedido));
  }
  //Encontrar por pedido
  getByIdPedido(idpedido: number): Observable<Artixpedido[]> {
    return this.http.get<Artixpedido[]>(`${baseUrl}/pedido/${idpedido}`);
  }

  //Encontrar por pedido asyncrono
  async getByIdPedidoAsync(idpedido: number): Promise<Artixpedido[]> {
    return firstValueFrom(this.http.get<Artixpedido[]>(`${baseUrl}/pedido/${idpedido}`));
  }
  //Encontrar por articulo
  getByIdArticulo(idarticulo: number): Observable<Artixpedido[]> {
    return this.http.get<Artixpedido[]>(`${baseUrl}/articulos/${idarticulo}`);
  }

  // ✅ Update Artixpedido
updateAll(
  idpedido: number,
  usumodi: number,
  fecmodi: Date,
  articulos: Articulos[]
): Observable<string> {
  const url = `${baseUrl}/delete_aritculo`;

  const params = new HttpParams()
    .set('idpedido', String(idpedido))
    .set('usumodi', String(usumodi))
    .set('fecmodi', fecmodi.toISOString()); // importante para Timestamp

  const headers = new HttpHeaders({
    'Content-Type': 'application/json',
  });

  return this.http.put(url, articulos, { params, headers, responseType: 'text' }).pipe(
    catchError((err) => {
      const msg = err?.error || 'Error actualizando artículos del pedido';
      return throwError(() => new Error(msg));
    })
  );
}

}

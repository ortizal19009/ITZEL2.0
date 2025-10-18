import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Artixpedido } from '../../modelos/existencias/artixpedido.model';
import { firstValueFrom, Observable } from 'rxjs';
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
  //Encontrar por articulo
  getByIdArticulo(idarticulo: number): Observable<Artixpedido[]> {
    return this.http.get<Artixpedido[]>(`${baseUrl}/articulos/${idarticulo}`);
  }
}

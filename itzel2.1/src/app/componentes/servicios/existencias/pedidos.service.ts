import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Pedidos } from '../../modelos/existencias/pedidos.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/pedidos`;
@Injectable({
  providedIn: 'root',
})
export class PedidosService {
  constructor(private http: HttpClient) {}
  getListaPedidos(): Observable<Pedidos[]> {
    return this.http.get<Pedidos[]>(`${baseUrl}`);
  }
  getPedidoById(idpedido: number): Observable<Pedidos> {
    return this.http.get<Pedidos>(`${baseUrl}/${idpedido}`);
  }
  getLastPedido(): Observable<number> {
    return this.http.get<number>(`${baseUrl}/last`);
  }
}

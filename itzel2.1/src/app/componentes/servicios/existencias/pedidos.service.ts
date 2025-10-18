import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient, HttpParams } from '@angular/common/http';
import { firstValueFrom, Observable } from 'rxjs';
import { Pedidos } from '../../modelos/existencias/pedidos.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/pedidos`;
@Injectable({
  providedIn: 'root',
})
export class PedidosService {
  constructor(private http: HttpClient) {}
  //Listar todos los pedidos
  getListaPedidos(): Observable<Pedidos[]> {
    return this.http.get<Pedidos[]>(`${baseUrl}`);
  }

  //Obtener pedido por ID
  getPedidoById(idpedido: number): Observable<Pedidos> {
    return this.http.get<Pedidos>(`${baseUrl}/${idpedido}`);
  }

  //Obtener último número de pedido
  getLastPedido(): Observable<number> {
    return this.http.get<number>(`${baseUrl}/last`);
  }

  //Guardar pedido (usado con async/await)
  async savePedido(pedido: Pedidos): Promise<Pedidos> {
    return firstValueFrom(this.http.post<Pedidos>(`${baseUrl}`, pedido));
  }

  //Eliminar pedido
  async deletePedido(idpedido: number): Promise<void> {
    await firstValueFrom(this.http.delete<void>(`${baseUrl}/${idpedido}`));
  }

  //Buscar pedidos por rango de fecha
  getPedidosPorFecha(inicio: string, fin: string): Observable<Pedidos[]> {
    const params = new HttpParams().set('inicio', inicio).set('fin', fin);
    return this.http.get<Pedidos[]>(`${baseUrl}/fecha`, { params });
  }

  //Buscar pedidos por número (rango)
  getPedidosPorNumero(inicio: number, fin: number): Observable<Pedidos[]> {
    const params = new HttpParams().set('inicio', inicio).set('fin', fin);
    return this.http.get<Pedidos[]>(`${baseUrl}/numero`, { params });
  }

  //Buscar pedidos por descripción
  getPedidosPorDescripcion(descripcion: string): Observable<Pedidos[]> {
    const params = new HttpParams().set('descripcion', descripcion);
    return this.http.get<Pedidos[]>(`${baseUrl}/descripcion`, { params });
  }

  //Buscar pedidos por nombre del beneficiario
  getPedidosPorBeneficiario(nombre: string): Observable<Pedidos[]> {
    const params = new HttpParams().set('nombre', nombre);
    return this.http.get<Pedidos[]>(`${baseUrl}/beneficiario`, { params });
  }

  //Obtener pedidos paginados
  getPedidosPaginados(
    page: number,
    size: number,
    sortBy: string,
    sortDir: string
  ): Observable<any> {
    const params = new HttpParams()
      .set('page', page)
      .set('size', size)
      .set('sortBy', sortBy)
      .set('sortDir', sortDir);
    return this.http.get<any>(`${baseUrl}/page`, { params });
  }
}

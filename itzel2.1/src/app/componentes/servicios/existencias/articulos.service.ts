import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Articulos } from '../../modelos/existencias/articulos.model';
import { Observable } from 'rxjs';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/articulos`;

@Injectable({
  providedIn: 'root',
})
export class ArticulosService {
  constructor(private http: HttpClient) {}

  //Busca la lista de articulos por Código, codcue y Nombre
  getByCodigoyCodueyNombre(codigo: String, codcue: String, nombre: String) {
    return this.http.get<Articulos[]>(
      `${baseUrl}/buscar?codigo=${codigo}&codcue=${codcue}&nombre=${nombre}`
    );
  }

  //Validar código
  valCodigo(codigo: string): Observable<boolean> {
    const url = `${baseUrl}/valcodigo/${encodeURIComponent(codigo)}`;
    return this.http.get<boolean>(url);
  }

  //Valida nombre
  valNombre(nombre: string): Observable<boolean> {
    const url = `${baseUrl}/valnombre?nombre=${nombre}`;
    return this.http.get<boolean>(url);
  }

  //Guardar nuevo
  saveArticulo(articulo: Articulos): Observable<Object> {
    return this.http.post(baseUrl, articulo);
  }

  //Buscar pot idarticulo
  getByIdarticulo(idarticulo: number) {
    return this.http.get<Articulos>(baseUrl + '/' + idarticulo);
  }

  //Modificar
  updateArticulo(idarticulo: number, articulo: Articulos): Observable<Object> {
    return this.http.put(baseUrl + '/' + idarticulo, articulo);
  }

  //Eliminar
  deleteArticulo(idarticulo: number) {
    return this.http.delete(`${baseUrl}/${idarticulo}`);
  }

  // Buscar por nombre, cuenta o codigo de partida
  getByNombreCuentaCodigo(term: string): Observable<Articulos[]> {
    return this.http.get<Articulos[]>(`${baseUrl}/data_search?dato=${term}`);
  }
}

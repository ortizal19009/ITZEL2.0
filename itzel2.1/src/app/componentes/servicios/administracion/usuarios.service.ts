import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Usuarios } from '../../modelos/administracion/usuarios.model';
import { firstValueFrom, Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/usuarios`;
@Injectable({
  providedIn: 'root'
})
export class UsuariosService {
  constructor(private http: HttpClient) {}

  getUsuarios(): Observable<Usuarios[]> {
    return this.http.get<Usuarios[]>(baseUrl);
  }

  //
  // getUsuario(a: String, b: String): Observable<boolean> {
  //   return this.http.get<boolean>(`${baseUrl}/usuario?a=${a}&b=${b}`);
  // }

  //Usuario
  getUsuario(a: String, b: String) {
    return this.http.get<Usuarios>(`${baseUrl}/usuario?a=${a}&b=${b}`);
  }

  getByIdentificacion(identificausu: string) {
    return this.http.get<Usuarios>(
      `${baseUrl}/identificacion?identificausu=${identificausu}`
    );
  }

  getByIdusuario(idusuario: number) {
    return this.http.get<Usuarios>(baseUrl + '/' + idusuario);
  }
  async getByIdusuarioAsync(idusuario: number): Promise<any> {
    const response = firstValueFrom(
      this.http.get<Usuarios>(baseUrl + '/' + idusuario)
    );
    return response;
  }

  updateUsuario(idusuario: number, usuario: Usuarios): Observable<Object> {
    return this.http.put(baseUrl + '/' + idusuario, usuario);
  }
  getDatosOfOne(idusuario: number) {
    return this.http.get(`${baseUrl}/one?idusuario=${idusuario}`);
  }
  getDatosOne(idusuario: number):Promise<any> {
    let resp = this.http.get(`${baseUrl}/one?idusuario=${idusuario}`);
    return firstValueFrom(resp);
  }
  save(usuario: any) {
    return this.http.post(`${baseUrl}`, usuario);
  }
}

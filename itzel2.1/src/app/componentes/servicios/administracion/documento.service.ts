import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Documentos } from '../../modelos/administracion/documentos.model';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/documentos`;
@Injectable({
  providedIn: 'root',
})
export class DocumentoService {
  constructor(private http: HttpClient) {}
  getAllDocumentos():Observable <Documentos[]> {
    return this.http.get<Documentos[]>(`${baseUrl}`);
  }
}

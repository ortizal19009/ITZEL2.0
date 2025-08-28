import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/estructura`;
@Injectable({
  providedIn: 'root'
})
export class EstructuraService {
    constructor(private http: HttpClient) {}

  estructuraGetAll() {
    return this.http.get(`${baseUrl}`);
  }
}

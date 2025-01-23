import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/niveles`;
@Injectable({
  providedIn: 'root',
})
export class NivelesService {
  constructor(private http: HttpClient) {}
  getAll() {
    return this.http.get(`${baseUrl}`);
  }
}

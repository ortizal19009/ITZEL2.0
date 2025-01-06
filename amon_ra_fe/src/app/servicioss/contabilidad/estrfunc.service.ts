import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/estrfunc`;
@Injectable({
  providedIn: 'root'
})
export class EstrfuncService {

  constructor(private http: HttpClient) { }
  getAll(){
    return this.http.get(`${baseUrl}`);
  }
}

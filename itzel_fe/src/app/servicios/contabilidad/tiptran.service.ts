import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/tiptran`;
@Injectable({
  providedIn: 'root'
})
export class TiptranService {

  constructor(private http: HttpClient) { }
}

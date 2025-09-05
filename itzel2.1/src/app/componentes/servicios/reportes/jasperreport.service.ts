import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/jasperReports`;
@Injectable({
  providedIn: 'root'
})
export class JasperreportService {
  constructor(private http: HttpClient) { }
  async getReporteOfJasper(datos: any): Promise<Blob> {
    return firstValueFrom(
      this.http.post(`${baseUrl}/reportes`, datos, {
        responseType: 'blob'  // 👈 Importante: indicamos que esperamos un binario
      })
    );
  }

}

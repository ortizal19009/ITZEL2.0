import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Benextran } from '../../modelos/contabilidad/benextran.model';


const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/benextran`;

@Injectable({
   providedIn: 'root'
})

export class BenextranService {

   constructor(private http: HttpClient) { }

   //Anticipos, CxC, Fondos de Terceros sin liquidar y CxP
   getACFP(hasta: Date, nomben: String, tiptran: number, codcue: String): Observable<Benextran[]> {
      return this.http.get<Benextran[]>(`${baseUrl}/acfp?hasta=${hasta}&nomben=${nomben}&tiptran=${tiptran}&codcue=${codcue}`);
   }

   //Guarda
   saveBenextran(benextran: Benextran): Observable<Object> {
      return this.http.post(baseUrl, benextran);
   }

   //Actualiza
   updateBenextran(idbenextran: number, benextran: Benextran): Observable<Object> {
      return this.http.put(baseUrl + "/" + idbenextran, benextran);
   }

}

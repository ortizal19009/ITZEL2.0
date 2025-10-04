import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Cuentas } from '../../modelos/contabilidad/cuentas.model';
import { firstValueFrom, Observable } from 'rxjs';

const apiUrl = environment.API_URL;
const baseUrl = `${apiUrl}/cuentas`;

@Injectable({
   providedIn: 'root'
})

export class CuentasService {

   constructor(private http: HttpClient) { }

   //Busca la lista de cuentas por Código y/o Nombre
   getByCodigoyNombre(codcue: String, nomcue: String) {
      return this.http.get<Cuentas[]>(`${baseUrl}/buscar?codcue=${codcue}&nomcue=${nomcue}`);
   }

   //Valida codcue
   valCodcue(codcue: string) {
      return this.http.get<boolean>(`${baseUrl}/valcodcue/${codcue}`);
   }

   //Valida nomcue
   valNomcue(nomcue: string) {
      return this.http.get<boolean>(`${baseUrl}/valnomcue/${nomcue}`);
   }

   //Cuenta por codcue
   getCuentaByCodcue(codcue: String) {
      return this.http.get<Cuentas>(`${baseUrl}/codcue/${codcue}`);
   }

   //Verifica si la cuenta tiene Desagregación Async
   async valDesagregaAsync(codcue: String): Promise<any> {
      const response = await firstValueFrom(this.http.get<any>(`${baseUrl}/desagrega/${codcue}`));
      return response;
   }

   //Cuentas por tiptran y codcue para datalist
   findByTiptran(tiptran: number, codcue: String) {
      return this.http.get<Cuentas[]>(`${baseUrl}/datalist?tiptran=${tiptran}&codcue=${codcue}`);
   }

   //Modificar
   updateCuenta(idcuenta: number, cuenta: Cuentas): Observable<Object> {
      return this.http.put(baseUrl + "/" + idcuenta, cuenta);
   }

   //Guardar
   saveCuenta(cuenta: Cuentas): Observable<Object> {
      return this.http.post(baseUrl, cuenta);
   }

   //Eliminar
   deleteCuenta(idcuenta: number): Observable<Object> {
      return this.http.delete(`${baseUrl}/${idcuenta}`);
   }

   // === BIENES ===

   //Busca la lista de cuentas de existencias por Código y/o Nombre
   getByCodigoyNombre3(codcue: String, nomcue: String) {
      return this.http.get<Cuentas[]>(`${baseUrl}/buscar3?codcue=${codcue}&nomcue=${nomcue}`);
   }


   // === EXISTENCIAS ===

   //Cuentas por codcue para datalist
   findByCodcue(codcue: string) {
      return this.http.get<Cuentas[]>(`${baseUrl}/existencias?codcue=${codcue}`);
   }

   //Busca la lista de cuentas de existencias por Código y/o Nombre
   getByCodigoyNombre2(codcue: String, nomcue: String) {
      return this.http.get<Cuentas[]>(`${baseUrl}/buscar2?codcue=${codcue}&nomcue=${nomcue}`);
   }

}

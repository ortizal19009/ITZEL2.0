import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Router } from '@angular/router';
import { DefinirService } from './definir.service';
import { UsuariosService } from './usuarios.service';
import { ReturnStatement } from '@angular/compiler';
import { Usuarios } from '../../modelos/administracion/usuarios.model';
import Swal from 'sweetalert2';
const backend = environment.BACK;

@Injectable({
  providedIn: 'root',
})

export class AutorizaService {

   private readonly STORAGE_EMPRESA = 'datosEmpresa';

   enabled = [false, false, false, false, false, false];
   colorenabled = false;
   modulo: number = 0;
   nomodulo: String = '';
   moduActual: number = 0;
   sessionlog: boolean = false;
   idusuario?: number;
   identificacion?: string;
   alias?: string;
   priusu?: string;
   swmodulo1: boolean = false;
   swmodulo2: boolean = false;
   swmodulo3: boolean = false;
   swmodulo4: boolean = false;
   swmodulo5: boolean = false;
   swmodulo6: boolean = false;
   msgval: boolean = false;

   swmusica: boolean = false;
   private readonly totMusica = 58;
   private audio: HTMLAudioElement | null = null;

   constructor(private defService: DefinirService, private usuService: UsuariosService) { }

   public enabModulos(): void {
      if (this.idusuario == 1) this.enabled = [true, true, true, true, true, true];
      else {
         const modulos = sessionStorage.getItem('efg');
         // const modulos1 = JSON.parse(atob(sessionStorage.getItem('abc')!));
         if (modulos) {
            this.enabled = JSON.parse(modulos!);
            // console.log('m: ', m)
            // this.enabled = [m.swmodulo1, m.swmodulo2, m.swmodulo3, m.swmodulo4, m.swmodulo5];
         }
         else this.enabled = [this.swmodulo1, this.swmodulo2, this.swmodulo3, this.swmodulo4, this.swmodulo5, this.swmodulo6];
      }
      this.colorenabled = true;
   }

   public selecModulo(opcion: number) {
      this.modulo = opcion;
      this.moduActual = opcion;
      const values = JSON.parse(atob(sessionStorage.getItem('abc')!));
      values.object.modulo = opcion;
      values.object.moduActual = opcion;
      this.nombreModulo();
      values.object.nomodulo = this.nomodulo;
      sessionStorage.setItem('abc', btoa(JSON.stringify(values)));

      //Actualiza usuarios.modulo para que la siguiente vez que entre esté en el último seleccionado
      this.usuService.getByIdusuario(this.idusuario!).subscribe({
         next: resp => {
            let usuario = {} as Usuarios; //Interface para los datos del Usuario
            usuario = resp;
            usuario.modulo = this.modulo;
            resp.modulo = this.modulo;
            this.usuService.updateUsuario(this.idusuario!, resp).subscribe({
               next: () => { },
               error: err => console.error(err.error)
            });
         },
         error: err => console.error(err.error)
      });
   }

   public nombreModulo() {
      let modulos: String[];
      modulos = ["Contabilidad gubernamental", "Existencias", "Control de bienes", "Rol de pagos", "Garantías", "Administración central"];
      this.nomodulo = modulos[this.moduActual - 1];
   }

   valsession() {
      const retrievedEncodedValues = sessionStorage.getItem('abc');
      if (retrievedEncodedValues !== null) {
         const retrievedValues = JSON.parse(atob(retrievedEncodedValues));
         this.sessionlog = true;
         this.idusuario = retrievedValues.idusuario;
         this.alias = retrievedValues.alias;
         this.modulo = retrievedValues.object.modulo;
         this.moduActual = retrievedValues.object.moduActual;
         this.nomodulo = retrievedValues.object.nomodulo;
         this.priusu = retrievedValues.priusu;
         this.msgval = retrievedValues.msgval;
         this.swmusica = retrievedValues.swmusica;
         this.enabModulos();
      }
      else this.getEmpresa();
   }

   //Obtiene y valida el nombre de la Empresa
   getEmpresa() {
      this.defService.getByIddefinir(1).subscribe({
         next: (resp:any) => {
            // OJO: Falta validar la Empresa con la licencia
            this.setDatosEmpresa({ 
               empresa: resp.empresa,
               ruc: resp.ruc ?? '',
               fechap: resp.fechap as Date,
               f_i: resp.f_i ?? '',
               f_g: resp.f_g ?? '',
               longparing:  resp.longparing ?? 0,
               longpargas:  resp.longpargas ?? 0,
            });
         },
         error: err => {
            console.error(err.error); this.mostrarError('Error al buscar', err.error);
         }
      });
   }

   setDatosEmpresa(datos: DatosEmpresa): void {
      sessionStorage.setItem(this.STORAGE_EMPRESA, JSON.stringify(datos));
   }

   getDatosEmpresa(): DatosEmpresa | null {
      const raw = sessionStorage.getItem(this.STORAGE_EMPRESA);
      return raw ? JSON.parse(raw) : null;
   }

   // Reproduce un audio aleatorio de la colección
   reproducirAudio(): void {
      // console.log('Pasa por reproducirAudio this.audio this.swmusica: ', this.swmusica)
      if (!this.swmusica) return; // Si la música está desactivada, no hace nada
      if (this.audio) {
         this.audio.pause();
         this.audio.src = '';
         this.audio.load();
         this.audio = null;
      }
      const now = new Date();
      const extraEntropy = (now.getMilliseconds() % 100) / 100;
      const randomFactor = (Math.random() + extraEntropy) % 1; // ahora es < 1
      const newIndex = Math.floor(randomFactor * this.totMusica) + 1;

      this.audio = new Audio(`/dist/sonidos/Musica_${newIndex.toString().padStart(2, '0')}.mp3`);
      // console.log('this.audio: ', this.audio)
      this.audio.load();
      this.audio.play();
   }

   // Detiene el audio actual y libera la referencia
   detenerAudio(): void {
      if (this.audio) {
         this.audio.pause();
         this.audio.src = ''; // Libera la referencia al archivo
         this.audio.load();   // Resetea el estado del reproductor
         this.audio = null;
      }
   }

   // Reproduce una canción específica
   playAudio(numcancion: number) {
      if (this.audio) {
         this.audio.pause();
         this.audio.src = '';
         this.audio.load();
         this.audio = null;
      }
      this.audio = new Audio(`/dist/sonidos/Musica_${numcancion.toString().padStart(2, '0')}.mp3`);
      this.audio.load();
      this.audio.play().then(() => {
      }).catch(error => {
         console.error('Error al reproducir:', error);
      });
   }

   mostrarError(titulo: string, excepcion: any): void {
      const excep = `<div class="text-left" style="text-align: left;">
                        <strong>Path:</strong> ${excepcion.path}<br>
                        <strong>Mensaje:</strong> ${excepcion.message}
                        </div>`;
      Swal.fire({
         width: '800px',
         title: titulo,
         html: excep,
         showConfirmButton: false,
         footer: '<div class="terminal-footer">Terminal IBM</div>',
         customClass: { popup: 'retro' },
      });
   }

}

export interface DatosEmpresa {
   empresa?: String;
   ruc: string;
   fechap: Date;
   f_i: String;
   f_g: String;
   longparing: number;
   longpargas: number;
}


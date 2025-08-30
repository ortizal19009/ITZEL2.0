import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Router } from '@angular/router';
import { DefinirService } from './definir.service';
import { UsuariosService } from './usuarios.service';
const backend = environment.BACK;

@Injectable({
  providedIn: 'root'
})
export class AutorizaService {
  // ======================
  // 🔹 Variables de sesión y usuario
  // ======================
  enabled = [false, false, false, false, false, false];
  colorenabled = false;
  modulo: number = 0;
  nomodulo: string = '';
  moduActual: number = 0;
  sessionlog: boolean = true; // OJO ES FALSO 
  idusuario?: number;
  identificacion?: string;
  alias?: string;
  priusu?: string;
  msgval: boolean = false;

  // ======================
  // 🔹 Configuración de módulos
  // ======================
  swmodulo1: boolean = false;
  swmodulo2: boolean = false;
  swmodulo3: boolean = false;
  swmodulo4: boolean = false;
  swmodulo5: boolean = false;
  swmodulo6: boolean = false;

  // ======================
  // 🔹 Música
  // ======================
  swmusica: boolean = false;
  private readonly totMusica = 58;
  private audio: HTMLAudioElement | null = null;

  // ======================
  // 🔹 Backend
  // ======================
  backend: number = backend;

  constructor(
    private router: Router,
    private defService: DefinirService,
    private usuService: UsuariosService
  ) {}

  // ======================
  // 🔹 Manejo de módulos
  // ======================
  public enabModulos(): void {
    if (this.idusuario == 1) {
      this.enabled = [true, true, true, true, true, true];
    } else {
      const modulos = sessionStorage.getItem('efg');
      this.enabled = modulos
        ? JSON.parse(modulos)
        : [this.swmodulo1, this.swmodulo2, this.swmodulo3, this.swmodulo4, this.swmodulo5, this.swmodulo6];
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

    // Actualiza usuario en BD
    this.usuService.getByIdusuario(this.idusuario!).subscribe({
      next: (resp: any) => {
        resp.modulo = opcion;
        this.usuService.updateUsuario(this.idusuario!, resp).subscribe({
          next: () => this.router.navigate(['/inicio']),
          error: (err: any) => console.error(err.error),
        });
      },
      error: (err: any) => console.error(err.error),
    });
  }

  public nombreModulo() {
    const modulos: string[] = [
      'Contabilidad gubernamental',
      'Existencias',
      'Control de bienes',
      'Rol de pagos',
      'Comprobantes electrónicos',
      'Administración central',
    ];
    this.nomodulo = modulos[this.moduActual - 1];
  }

  // ======================
  // 🔹 Manejo de sesión
  // ======================
valsession() {
  if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
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
  } else {
    console.warn('sessionStorage no disponible (SSR o entorno server)');
    // Aquí puedes inicializar valores por defecto si quieres
  }
}


  // Obtiene y valida el nombre de la Empresa
  private nomEmpresa() {
    this.defService.getByIddefinir(1).subscribe({
      next: (resp: any) => {
        sessionStorage.setItem('empresa', JSON.stringify({
          empresa: resp.empresa,
          fechap: resp.fechap
        }));
      },
      error: (err: any) => console.error(err.error),
    });
  }

  // ======================
  // 🔹 Música
  // ======================
  reproducirAudio(): void {
    if (!this.swmusica) return;
    this.detenerAudio();

    const now = new Date();
    const randomFactor = (Math.random() + (now.getMilliseconds() % 100) / 100) % 1;
    const newIndex = Math.floor(randomFactor * this.totMusica) + 1;

    this.audio = new Audio(`/dist/sonidos/Megan_${newIndex.toString().padStart(2, '0')}.mp3`);
    this.audio.load();
    this.audio.play();
  }

  detenerAudio(): void {
    if (this.audio) {
      this.audio.pause();
      this.audio.src = '';
      this.audio.load();
      this.audio = null;
    }
  }

  playAudio(numcancion: number) {
    this.detenerAudio();

    this.audio = new Audio(`/dist/sonidos/Megan_${numcancion.toString().padStart(2, '0')}.mp3`);
    this.audio.load();
    this.audio.play().catch((error) => {
      console.error('Error al reproducir:', error);
    });
  }
}


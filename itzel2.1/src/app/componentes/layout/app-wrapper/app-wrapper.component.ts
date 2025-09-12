import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { AutorizaService } from '../../servicios/administracion/autoriza.service';
import { UsuariosService } from '../../servicios/administracion/usuarios.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { StorageService } from '../../servicios/config/storage-service';

@Component({
  selector: 'app-app-wrapper',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './app-wrapper.component.html',
  styleUrl: './app-wrapper.component.css',
})
export class AppWrapperComponent implements OnInit {
  hover: boolean = false;
  totalImages = 11;
  currentIndex = Math.floor(Math.random() * this.totalImages) + 1;
  imageUrl = `/dist/img/itzel_${this.currentIndex.toString().padStart(2, '0')}.png`;

  formLogin!: FormGroup;
  msg: boolean = false;
  bloqueado: boolean = false;
  kont: number = 0;

  constructor(
    public fb: FormBuilder,
    public authService: AutorizaService,
    private usuService: UsuariosService
  ) {}

  ngOnInit(): void {
    setInterval(() => this.changeImage(), 2000);

    sessionStorage.setItem('ventana', '/inicio');

    this.formLogin = this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]],
      codusu: ['', [Validators.required, Validators.minLength(5)]],
    });
    // console.log('Va a this.authService.session()')
    this.authService.valsession();
  }

  get f() {
    return this.formLogin.controls;
  }

  changeImage() {
    let newIndex;
    do {
      newIndex = Math.floor(Math.random() * this.totalImages) + 1;
    } while (newIndex === this.currentIndex);
    this.currentIndex = newIndex;
    this.imageUrl = `/dist/img/itzel_${newIndex.toString().padStart(2, '0')}.png`;
  }

  login() {
    let b = myFun(this.formLogin.value.codusu);
    this.msg = false;
    this.usuService.getUsuario(this.formLogin.value.username, b).subscribe({
      next: (resp: any) => {
        console.log(resp);
        if (resp) {
          // console.log('resp:', resp)
          sessionStorage.clear();
          this.authService.getEmpresa();
          this.authService.sessionlog = true;
          this.authService.idusuario = resp.idusuario;
          this.authService.identificacion = resp.identificacion;
          this.authService.alias = resp.alias;
          this.authService.modulo = resp.modulo!;
          this.authService.moduActual = resp.modulo!;
          this.authService.priusu = resp.priusu;
          this.authService.swmodulo1 = resp.swmodulo1!;
          this.authService.swmodulo2 = resp.swmodulo2!;
          this.authService.swmodulo3 = resp.swmodulo3!;
          this.authService.swmodulo4 = resp.swmodulo4!;
          this.authService.swmodulo5 = resp.swmodulo5!;
          this.authService.swmodulo6 = resp.swmodulo6!;
          this.authService.swmusica = resp.swmusica!;
          this.authService.msgval = resp.msgval!;

          this.authService.nombreModulo();
          const abc = {
            object: {
              name: 'RcR',
              xyz: true,
              modulo: resp.modulo,
              moduActual: resp.modulo,
              nomodulo: this.authService.nomodulo,
            },
            idusuario: resp.idusuario,
            alias: resp.alias,
            priusu: resp.priusu,
            swmusica: resp.swmusica,
            msgval: resp.msgval,
          };
          sessionStorage.setItem('abc', btoa(JSON.stringify(abc)));
          const modulos = [
            this.authService.swmodulo1,
            this.authService.swmodulo2,
            this.authService.swmodulo3,
            this.authService.swmodulo4,
            this.authService.swmodulo5,
            this.authService.swmodulo6,
          ];
          sessionStorage.setItem('efg', JSON.stringify(modulos));
          this.authService.enabModulos();
          this.authService.reproducirAudio();
        } else {
          this.msg = true;
          this.kont++;
          if (this.kont > 3) this.bloqueado = true;
        }
      },
      error: (err) => console.error(err.error),
    });
  }

  reinicia() {
    this.msg = false;
  }
}

function myFun(x: string): string {
  let y = '';
  for (let i = 0; i < x.length; i++) {
    y += String(x.charCodeAt(i));
  }
  let rtn = '';
  for (let i = 0; i < y.length; i += 2) {
    rtn += y[i];
  }
  rtn += String(x.trim().length);
  for (let i = y.length - 1; i >= 0; i -= 2) {
    rtn += y[i];
  }
  return rtn;
}

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
  templateUrl: './app-wrapper.html',
  styleUrl: './app-wrapper.css',
})
export class AppWrapper implements OnInit {
  formLogin!: FormGroup;
  msg = false;
  kont = 0;
  bloqueado = false;

  constructor(
    private fb: FormBuilder,
    private storage: StorageService, // 👈 inyectar
    public authService: AutorizaService,
    private usuService: UsuariosService
  ) {}

  ngOnInit(): void {
    this.storage.setItem('ventana', '/inicio');

    this.formLogin = this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(20)]],
      codusu: ['', [Validators.required, Validators.minLength(5)]],
    });

    this.authService.valsession();
  }

  get f() {
    return this.formLogin.controls;
  }

  login() {
    let b = myFun(this.formLogin.value.codusu);

    this.msg = false;
    this.usuService.getUsuario(this.formLogin.value.username, b).subscribe({
      next: (resp: any) => {
        if (resp) {
          this.storage.clear(); // 👈 en vez de sessionStorage.clear()
          this.authService.sessionlog = true;
          this.authService.idusuario = resp.idusuario;
          this.authService.alias = resp.alias;
          this.authService.modulo = 1;
          this.authService.moduActual = 1;
          this.authService.priusu = resp.priusu;

          const abc = {
            object: {
              name: 'RcR',
              xyz: true,
              modulo: 1,
              moduloActual: 1,
            },
            idusuario: resp.idusuario,
            alias: resp.alias,
            priusu: resp.priusu,
          };

          this.storage.setItem('abc', btoa(JSON.stringify(abc))); // 👈

          this.authService.enabModulos();
        } else {
          this.msg = true;
          this.kont++;
          if (this.kont > 3) this.bloqueado = true;
        }
      },
      error: (err: any) => console.error(err.error),
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

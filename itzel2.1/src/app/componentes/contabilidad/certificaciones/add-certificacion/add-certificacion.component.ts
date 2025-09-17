import { Component, OnInit } from '@angular/core';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Certificacion } from '../../../modelos/contabilidad/certificacion.model';
import { CertificacionesService } from '../../../servicios/contabilidad/certificaciones.service';
import { DocumentoService } from '../../../servicios/administracion/documento.service';

@Component({
  selector: 'app-add-certificacion.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './add-certificacion.component.html',
  styleUrl: './add-certificacion.component.css',
})
export class AddCertificacionComponent implements OnInit {
  title: string = 'Neva Certificación';
  f_certificacion!: FormGroup;
  certificacion: Certificacion = new Certificacion();
  date: Date = new Date();
  constructor(
    public authService: AutorizaService,
    private router: Router,
    private coloresService: ColoresService,
    private fb: FormBuilder, 
    private s_certificaciones: CertificacionesService, 
    private s_documentos: DocumentoService
  ) {}
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/add-certificacion');
      let coloresJSON = sessionStorage.getItem('/add-certificacion');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.f_certificacion = this.fb.group({
      numero: '',
      valor: '',
      descripcion: '',
      numdoc: '',
      usucrea: this.authService.idusuario,
      feccrea: this.date,
      beneficiario: '',
      beneficiariores: '',
      documento: '',
    });
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(
        this.authService.idusuario!,
        'add-certificacion'
      );
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/add-certificacion', coloresJSON);
      this.colocaColor(datos);
    } catch (error) {
      console.error('Al buscar la ventana: ', error);
    }
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
  }
  get f() {
    return this.f_certificacion.controls;
  }
  regresar() {
    this.router.navigate(['/certificaciones']);
  }
  save() {}
}

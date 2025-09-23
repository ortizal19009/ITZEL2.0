import { Component } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import Swal from 'sweetalert2';
import { Beneficiario } from '../../../modelos/contabilidad/beneficiario.model';
import { Certificacion } from '../../../modelos/contabilidad/certificacion.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { debounceTime, distinctUntilChanged, filter, switchMap } from 'rxjs';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { CertificacionesService } from '../../../servicios/contabilidad/certificaciones.service';
import { DocumentoService } from '../../../servicios/administracion/documento.service';
import { BeneficiarioService } from '../../../servicios/contabilidad/beneficiario.service';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { VisualFormatDirective } from '../../../directives/visual-format.directive';

@Component({
  selector: 'app-modi-certificacion.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule, VisualFormatDirective],
  templateUrl: './modi-certificacion.component.html',
  styleUrl: './modi-certificacion.component.css',
})
export class ModiCertificacionComponent {
  title: string = 'Neva Certificación';
  f_certificacion!: FormGroup;
  certificacion: Certificacion = new Certificacion();
  date: Date = new Date();
  _documentos: Documentos[] = [];
  _beneficiarios: Beneficiario[] = [];
  _responsable: Beneficiario[] = [];
  today = new Date().toISOString().substring(0, 10); // ejemplo: "2025-09-19"
  idcertificacion?: number;
  constructor(
    public authService: AutorizaService,
    private router: Router,
    private coloresService: ColoresService,
    private fb: FormBuilder,
    private s_certificaciones: CertificacionesService,
    private s_documentos: DocumentoService,
    private s_beneficiario: BeneficiarioService,
    private _params: ActivatedRoute
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
    this.idcertificacion = +this._params.snapshot.paramMap.get('idcertificacion')!;

    this.f_certificacion = this.fb.group({
      numero: ['', [Validators.required, Validators.minLength(1)]],
      valor: [0.0, [Validators.required, Validators.minLength(1)]],
      fecha: [
        this.today,
        [
          Validators.required,
          Validators.pattern(/^\d{4}-\d{2}-\d{2}$/),
          maxDateValidator(new Date()), // no después de hoy
        ],
      ],
      descripcion: ['', [Validators.required, Validators.minLength(10)]],
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      usucrea: [this.authService.idusuario],
      feccrea: [this.date],
      beneficiario: [''],
      nombene: ['', [Validators.required, Validators.minLength(5)]],
      beneficiariore: [''],
      nomresponsable: ['', [Validators.required, Validators.minLength(5)]],
      documento: null,
    });
    this.f_certificacion
      .get('nombene')
      ?.valueChanges.pipe(
        filter((val) => val && val.length > 2),
        debounceTime(300),
        distinctUntilChanged(),
        switchMap((val) => this.s_beneficiario.findByNomben(val))
      )
      .subscribe((beneficiarios) => (this._beneficiarios = beneficiarios));

    this.getAllDocumentos();
    this.getLastCertificacionByTipo();
    this.getBeneById(1);
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
  save() {
    let certificacion: Certificacion = new Certificacion();
    let f = this.f_certificacion.value;
    certificacion.numero = f.numero;
    certificacion.valor = f.valor;
    certificacion.fecha = f.fecha;
    certificacion.descripcion = f.descripcion;
    certificacion.numdoc = f.numdoc;
    certificacion.usucrea = f.usucrea;
    certificacion.tipo = 1;
    certificacion.feccrea = f.feccrea;
    certificacion.beneficiario = f.beneficiario;
    certificacion.beneficiariore = f.beneficiariore;
    certificacion.documento = f.documento;
    this.s_certificaciones.saveCertificacion(certificacion).subscribe({
      next: (c: any) => {
        this.swal('success', 'Certificación guardada con exito');
        this.regresar();
      },
      error: (e: any) => {
        this.authService.mostrarError('error', e.error);
      },
    });
  }
  getLastCertificacionByTipo() {
    this.s_certificaciones.findLastByTipo(1).subscribe({
      next: (certificacion: Certificacion) => {
        console.log(certificacion);
        let numero: number = 1;
        if (certificacion != null) {
          numero = certificacion.numero + 1;
        }
        this.f_certificacion.patchValue({
          numero: numero,
        });
      },
      error: (e: any) => console.error(e),
    });
  }
  getAllDocumentos() {
    this.s_documentos.getAllDocumentos().subscribe({
      next: (documentos: Documentos[]) => {
        this._documentos = documentos;
        this.f_certificacion.patchValue({
          documento: documentos[0],
        });
      },
      error: (e: any) => {
        console.error(e.error);
        this.authService.mostrarError('error', e.error);
      },
    });
  }

  // cada vez que el usuario escribe
  getBeneficiario(event: any) {
    const value = event.target.value;
    // si escribió más de 2 letras, buscar en el backend
    this.s_beneficiario.findByNomben(value).subscribe({
      next: (beneficiarios: Beneficiario[]) => {
        this._beneficiarios = beneficiarios;
      },
      error: (e: any) => console.error(e),
    });

    // si seleccionó uno exacto de la lista
    const beneficiario = this._beneficiarios.find((b) => b.nomben === value);
    if (beneficiario) {
      this.f_certificacion.patchValue({
        beneficiario: beneficiario,
        nombene: beneficiario.nomben,
      });
    }
  }
  // cada vez que el usuario escribe
  getBeneficiariore(event: any) {
    const value = event.target.value;
    // si escribió más de 2 letras, buscar en el backend
    this.s_beneficiario.findByNomben(value).subscribe({
      next: (beneficiariore: Beneficiario[]) => {
        this._responsable = beneficiariore;
      },
      error: (e: any) => console.error(e),
    });

    // si seleccionó uno exacto de la lista
    const beneficiariore = this._responsable.find((b) => b.nomben === value);
    if (beneficiariore) {
      this.f_certificacion.patchValue({
        beneficiariore: beneficiariore,
        nomresponsable: beneficiariore.nomben,
      });
    }
  }
  getBeneById(id: number) {
    this.s_beneficiario.getById(id).subscribe({
      next: (bene: Beneficiario) => {
        this.f_certificacion.patchValue({
          beneficiario: bene,
          nombene: bene.nomben,
        });
      },
      error: (e: any) => console.error(e.error),
    });
  }
  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
    });
  }
}
function maxDateValidator(max: Date) {
  return (control: AbstractControl): ValidationErrors | null => {
    if (!control.value) return null;
    const valueDate = new Date(control.value);
    return valueDate > max ? { maxDate: true } : null;
  };
}

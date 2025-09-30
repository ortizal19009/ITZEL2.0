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
import { Beneficiarios } from '../../../modelos/contabilidad/beneficiarios.model';
import { Documentos } from '../../../modelos/administracion/documentos.model';
import { Certificaciones } from '../../../modelos/contabilidad/certificaciones.model';
import { CommonModule } from '@angular/common';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { CertificacionesService } from '../../../servicios/contabilidad/certificaciones.service';
import { DocumentosService } from '../../../servicios/administracion/documentos.service';
import { BeneficiariosService } from '../../../servicios/contabilidad/beneficiarios.service';
import { Router } from '@angular/router';
import { debounceTime, distinctUntilChanged, filter, of, switchMap } from 'rxjs';

@Component({
  selector: 'app-add-reintegro.component',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './add-reintegro.component.html',
  styleUrl: './add-reintegro.component.css',
})
export class AddReintegroComponent {
  formCertificacion!: FormGroup;
  date: Date = new Date();
  _documentos: Documentos[] = [];
  _beneficiarios: Beneficiarios[] = [];
  idbeneficiario: number | null = null;
  _responsables: Beneficiarios[] = [];
  idresponsable: number | null = null;
  constructor(
    public authService: AutorizaService,
    private router: Router,
    private colorService: ColoresService,
    private fb: FormBuilder,
    private s_certificaciones: CertificacionesService,
    private docuService: DocumentosService,
    private beneService: BeneficiariosService
  ) {}

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/certificaciones');
      let coloresJSON = sessionStorage.getItem('/certificaciones');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    const fechaObj: Date = new Date();
    const fecha = fechaObj.toISOString().substring(0, 10);
    this.idbeneficiario = 1;
    this.formCertificacion = this.fb.group(
      {
        numero: [0, [Validators.required, Validators.minLength(1)], [this.valNumero.bind(this)]],
        valor: [0.0, [Validators.required, Validators.minLength(1)]],
        fecha: [fecha, Validators.required, this.valAño.bind(this)],
        documento: null,
        numdoc: ['', [Validators.required, Validators.maxLength(12)]],
        beneficiario: ['(Ninguno)', [Validators.required], [this.valBeneficiario.bind(this)]],
        responsable: ['', [Validators.required], [this.valResponsable.bind(this)]],
        descripcion: [
          '',
          [Validators.required, Validators.minLength(10), Validators.maxLength(254)],
        ],

        usucrea: [this.authService.idusuario],
        feccrea: [this.date],
      },
      { updateOn: 'blur' }
    );

    this.getAllDocumentos();
    this.getLastCertificacionByTipo();
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
    this.colorForaneas();
  }

  async colorForaneas() {
    try {
      let datos: string;
      datos = await this.colorService.getcolor(this.authService.idusuario!, 'documentos');
      document.documentElement.style.setProperty('--bgcolor3', datos);
      const documentos = document.querySelector('.documentos');
      if (documentos) documentos.classList.add('nuevoBG3');
    } catch (error) {
      console.error(error);
    }
  }

  get f() {
    return this.formCertificacion.controls;
  }

  getLastCertificacionByTipo() {
    this.s_certificaciones.findLastByTipo(2).subscribe({
      next: (certificacion: Certificaciones) => {
        let numero: number = 1;
        if (certificacion != null) {
          numero = certificacion.numero + 1;
        }
        this.formCertificacion.patchValue(
          { numero: numero },
          { emitEvent: true } // <- asegura que dispare validaciones
        );
      },
      error: (e: any) => console.error(e),
    });
  }

  getAllDocumentos() {
    this.docuService.getListaDocumentos().subscribe({
      next: (documentos: Documentos[]) => {
        this._documentos = documentos;
        this.formCertificacion.patchValue({ documento: 1 });
      },
      error: (e: any) => {
        console.error(e.error);
        this.authService.mostrarError('error', e.error);
      },
    });
  }

  //Datalist de los Beneficiarios
  beneficiariosxNomben(e: any) {
    if (e.target.value != '') {
      this.beneService.findByNomben(e.target.value).subscribe({
        next: (beneficiarios: Beneficiarios[]) => (this._beneficiarios = beneficiarios),
        error: (err) => {
          console.error(err.error);
          this.authService.mostrarError('Error al buscar los Beneficiarios', err.error);
        },
      });
    }
  }
  onBeneficiarioSelected(e: any) {
    const selectedOption = this._beneficiarios.find(
      (x: { nomben: any }) => x.nomben === e.target.value
    );
    if (selectedOption) this.idbeneficiario = selectedOption.idbeneficiario;
    else this.idbeneficiario = null;
  }

  //Datalist de los Responsables
  responsablesxNomben(e: any) {
    if (e.target.value != '') {
      this.beneService.findByNomben(e.target.value).subscribe({
        next: (responsables: Beneficiarios[]) => (this._responsables = responsables),
        error: (err) => {
          console.error('Error al buscar los Beneficiarios (responsables)', err.error);
          this.authService.mostrarError('Error al buscar los Responsables', err.error);
        },
      });
    }
  }
  onResponsableSelected(e: any) {
    const selectedOption = this._responsables.find(
      (x: { nomben: any }) => x.nomben === e.target.value
    );
    if (selectedOption) this.idresponsable = selectedOption.idbeneficiario;
    else this.idresponsable = null;
  }

  guardar() {
    let newCerti: Certificaciones; //Para evitar los mensaje de validacion en el formulario
    newCerti = this.formCertificacion.value;
    newCerti.tipo = 2;
    const docSeleccionado = this._documentos.find(
      (d) => d.iddocumento === this.formCertificacion.value.documento
    );
    newCerti.documento = docSeleccionado!;
    let beneficiario: Beneficiarios = new Beneficiarios();
    beneficiario.idbeneficiario = this.idbeneficiario!;
    newCerti.beneficiario = beneficiario;
    let responsable: Beneficiarios = new Beneficiarios();
    responsable.idbeneficiario = this.idresponsable!;
    newCerti.beneficiariores = responsable;
    this.s_certificaciones.saveCertificacion(newCerti).subscribe({
      next: () => {
        this.swal('success', 'Reintegro guardado con exito');
        this.regresar();
      },
      error: (err) => {
        console.error('Al guardar el Compromiso: ', err.error);
        this.authService.mostrarError('Error al guardar', err.error);
      },
    });
  }

  regresar() {
    this.router.navigate(['/reintegros']);
  }

  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon: icon,
      title: mensaje,
      position: 'top',
      showConfirmButton: false,
      timer: 2000,
    });
  }

  //Valida el año de la fecha
  valAño(control: AbstractControl) {
    const empresa = this.authService.getDatosEmpresa();
    const año = empresa!.fechap.toString().slice(0, 4);
    const año1 = control.value.toString().slice(0, 4);
    if (año != año1) return of({ añoinvalido: true });
    else return of(null);
  }

  //Valida que se haya seleccionado un Beneficiario
  valBeneficiario(control: AbstractControl) {
    if (this.idbeneficiario == null) return of({ invalido: true });
    else return of(null);
  }

  //Valida que se haya seleccionado un Responsable
  valResponsable(control: AbstractControl) {
    if (this.idresponsable == null) return of({ invalido: true });
    else return of(null);
  }
  //Valida si el numero ya existe
  async valNumero(control: AbstractControl): Promise<any> {
    const value = control.value;

    if (!value || value.toString().trim() === '') {
      return Promise.resolve(null); // no hay error si está vacío
    }

    return this.s_certificaciones
      .isAvailable(2, value)
      .then((res: boolean) => {
        const error = res ? null : { existe: true };

        // Posponer para evitar NG0100
        setTimeout(() => control.setErrors(error), 0);

        return error;
      })
      .catch(() => null);
  }
}

import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Documentos } from '../../../../modelos/administracion/documentos.model';
import { Destinos } from '../../../../modelos/existencias/destinos.model';
import { Beneficiarios } from '../../../../modelos/contabilidad/beneficiarios.model';
import { Router } from '@angular/router';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { DocumentosService } from '../../../../servicios/administracion/documentos.service';
import { BeneficiariosService } from '../../../../servicios/contabilidad/beneficiarios.service';
import { DestinosService } from '../../../../servicios/existencias/destinos.service';
import { MovimientoService } from '../../../../servicios/existencias/movimiento.service';
import { Movimientos } from '../../../../modelos/existencias/movimientos.model';

@Component({
  selector: 'app-modi-ingreso.component',
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './modi-ingreso.component.html',
  styleUrl: './modi-ingreso.component.css'
})
export class ModiIngresoComponent implements OnInit {
  formMovimiento!: FormGroup;
  today: Date = new Date();
  _documentos: Documentos[] = [];
  _destinos: Destinos[] = [];
  _beneficiarios: Beneficiarios[] = [];
  tipmov: number = 1; // DEFIMIR MOVIMIENTOS DE INGRESO
  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private s_documentos: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private movService: MovimientoService
  ) { }
  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }
    sessionStorage.setItem('ventana', '/mov-ingresos');
    let idmov = sessionStorage.getItem('idToModIngMovimientos')
    this.getAllDocumentos();
    this.getAllDestinos();
    this.getLastNumeroMovimiento();
    let coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
    this.formMovimiento = this.fb.group({
      numero: [
        0,
        [
          Validators.required,
          Validators.min(1),
          Validators.pattern(/^[1-9]\d*$/), // Solo enteros positivos
        ],
      ],
      fecha: [this.today.toISOString().substring(0, 10), [Validators.required]],
      // 👇 corregido: todos los sync validators al 2º argumento
      idmovimiento: [''],
      numentrada: ['', [Validators.required, Validators.minLength(2)]],
      total: [''],
      numart: [''],
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      documento: [''],
      fecdoc: [this.today.toISOString().substring(0, 10), [Validators.required]],
      swaprobado: [false],
      beneficiarioText: ['', [Validators.required]],
      destinoText: ['', [Validators.required]],
      beneficiario: [null, Validators.required],
      destino: [null, Validators.required],
      compegre: ['', Validators.required],
      observaciones: [''],
    });
    this.getMovimientoById(Number(idmov));
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');
    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
    this.formMovimiento = this.fb.group({});
  }
  get f() {
    return this.formMovimiento.controls;
  }
  guardar() {
    let movimiento: Movimientos = new Movimientos();
    let f = this.formMovimiento.value;
    console.log(f);
    movimiento.tipmov = this.tipmov;
    movimiento.numero = f.numero;
    movimiento.fecha = f.fecha;
    movimiento.numentrada = f.numentrada;
    movimiento.total = 0;
    movimiento.numart = 0;
    movimiento.documento = f.documento;
    movimiento.numdoc = f.numdoc;
    movimiento.fecdoc = f.fecdoc;
    movimiento.swaprobado = f.swaprobado;
    movimiento.beneficiario = f.beneficiario;
    movimiento.destino = f.destino;
    movimiento.compegre = f.compegre;
    movimiento.observaciones = f.observaciones;
    movimiento.feccrea = new Date();
    movimiento.usucrea = this.authService.idusuario;
    console.log('MOVIMIENTO A GUARDAR: ', movimiento);
    this.movService.saveMovimiento(movimiento).subscribe({
      next: (data) => {
        console.log(data);
        this.router.navigate(['/mov-ingresos']);
      }, error: (e) => console.error(e)
    });
  }
  regresar() {
    this.router.navigate(['/mov-ingresos']);
  }
  numAvailable(event: any) {
    console.log('VERIFICANDO SI EL NÚMERO ESTA DISPONIBLE ', event.target.value);
    const num = event.target.value;
    if (!num) return;

    this.movService.getNumAvailable(this.tipmov, +num!).subscribe({
      next: (disponible: boolean) => {
        const numeroControl = this.formMovimiento.get('numero');

        if (!disponible) {
          // Si NO está disponible, marcamos error personalizado
          numeroControl?.setErrors({ notAvailable: true });
        } else {
          // Si está disponible, quitamos el error (si lo tenía)
          if (numeroControl?.hasError('notAvailable')) {
            numeroControl.setErrors(null);
          }
        }
      },
      error: (err) => {
        console.error('Error verificando número:', err);
      },
    });
  }
  getLastNumeroMovimiento() {
    this.movService.findUltimo(this.tipmov).subscribe({
      next: (data: number) => {
        console.log(data);
        this.formMovimiento.patchValue({
          numero: data + 1,
        });
      },
    });
  }
  getAllDocumentos() {
    this.s_documentos.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        this._documentos = data;
        this.formMovimiento.patchValue({
          documento: data[0],
        });
      },
      error: (e) => console.error(e.error),
    });
  }
  onDestinoTyped(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    this.formMovimiento.patchValue({ destino: dest });
  }
  onDestinoSelected(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    if (dest) {
      this.formMovimiento.patchValue({
        destino: dest,
        destinoText: dest.nomdestino,
      });
    } else {
      this.formMovimiento.patchValue({ destino: null });
    }
    this.f['destino'].markAsTouched();
  }
  onBeneficiarioTyped(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    // limpia el objeto si el usuario sigue tecleando
    this.formMovimiento.patchValue({ beneficiario: null });
    this.getAllBeneficiarios(raw, (lista) => {
      // intenta atar automáticamente si el texto coincide exactamente con un nombre
      const bene = lista.find((b) => (b.nomben || '').toLowerCase() === key) || null;
      if (bene) {
        setTimeout(() => {
          this.formMovimiento.patchValue({
            beneficiario: bene,
            beneficiarioText: bene.nomben,
          });
        });
      }

    });
  }
  getAllDestinos() {
    this.destService.getListaDestinos().subscribe({
      next: (data: Destinos[]) => {
        this._destinos = data;
      },
      error: (e) => {
        this.authService.mostrarError('error', e.error);
      },
    });
  }
  onBeneficiarioSelected(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();
    let bene = this._beneficiarios?.find((b) => (b.nomben || '').toLowerCase() === key) || null;
    if (!bene) {
      this.getAllBeneficiarios(raw, (lista) => {
        const b = lista.find((x) => (x.nomben || '').toLowerCase() === key) || null;
        this.formMovimiento.patchValue({
          beneficiario: b,
          beneficiarioText: b ? b.nomben : raw, // deja lo escrito si no encontró
        });
        this.formMovimiento.get('beneficiario')?.markAsTouched();
      });
      return;
    }

    // si lo encontró en la lista actual
    this.formMovimiento.patchValue({
      beneficiario: bene,
      beneficiarioText: bene.nomben,
    });
    this.formMovimiento.get('beneficiario')?.markAsTouched();
  }
  getAllBeneficiarios(query: string, onLoaded?: (lista: Beneficiarios[]) => void): void {
    const nombreVal = query?.trim();

    // 🟡 Validación temprana: si no hay texto, limpiamos la lista
    if (!nombreVal) {
      this._beneficiarios = [];
      onLoaded?.([]);
      return;
    }

    this.beneService.findByPrefixAndNombre('P', nombreVal).subscribe({
      next: (data: Beneficiarios[] = []) => {
        console.log(data);
        this._beneficiarios = Array.isArray(data) ? data : [];
        onLoaded?.(this._beneficiarios);
      },
      error: (error) => {
        this._beneficiarios = [];
        // Si tienes un servicio de alertas, puedes habilitar esta línea:
        // this.authService.mostrarError('Error', error?.error || 'No se pudieron cargar los beneficiarios');
        onLoaded?.([]);
      },
      complete: () => {
        console.debug('ℹ️ Consulta de beneficiarios finalizada.');
      },
    });
  }
  compareDocumentos(o1: Documentos, o2: Documentos): boolean {
    // Si ambos son null o undefined, se consideran iguales
    if (o1 === null || o2 === null) return o1 === o2;
    // Comparamos por id (o por el campo que identifique al documento)
    return o1.iddocumento === o2.iddocumento;
  }

  getMovimientoById(id: number) {
    this.movService.getMovimientoById(id).subscribe({
      next: (data: Movimientos) => {
        console.log(data);
        this.formMovimiento.setValue({
          idmovimiento: data.idmovimiento,
          numero: data.numero,
          fecha: new Date(data.fecha).toISOString().substring(0, 10),
          numentrada: data.numentrada,
          total: data.total,
          numart: data.numart,
          documento: data.documento,
          numdoc: data.numdoc,
          fecdoc: new Date(data.fecdoc).toISOString().substring(0, 10),
          swaprobado: data.swaprobado,
          beneficiario: data.beneficiario,
          destino: data.destino,
          compegre: data.compegre,
          observaciones: data.observaciones,
          beneficiarioText: data.beneficiario ? data.beneficiario.nomben : '',
          destinoText: data.destino ? data.destino.nomdestino : '',
        });
      },
      error: (e) => console.error(e)
    });
  }
}

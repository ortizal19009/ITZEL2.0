import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  ValidationErrors,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { Documentos } from '../../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../../servicios/administracion/documentos.service';
import { Destinos } from '../../../../modelos/existencias/destinos.model';
import { Beneficiarios } from '../../../../modelos/contabilidad/beneficiarios.model';
import { BeneficiariosService } from '../../../../servicios/contabilidad/beneficiarios.service';
import { DestinosService } from '../../../../servicios/existencias/destinos.service';
import { MovimientoService } from '../../../../servicios/existencias/movimiento.service';
import { Movimientos } from '../../../../modelos/existencias/movimientos.model';
import { Articulos } from '../../../../modelos/existencias/articulos.model';
import { ArtimoviService } from '../../../../servicios/existencias/artimovi.service';
import { CuentasService } from '../../../../servicios/contabilidad/cuentas.service';

export interface ArticuloMovimiento {
  articulo: Articulos;
  cantidad: number;
  costotal: number; // cosactual * cantidad
}

@Component({
  selector: 'app-add-ingreso.component',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './add-ingreso.component.html',
  styleUrl: './add-ingreso.component.css',
})
export class AddIngresoComponent implements OnInit {
  today: Date = new Date();

  formMovimiento!: FormGroup;
  formArticuloAdd!: FormGroup;

  _documentos: Documentos[] = [];
  _destinos: Destinos[] = [];
  _beneficiarios: Beneficiarios[] = [];

  _articulosSelected: ArticuloMovimiento[] = [];

  tipmov: number = 1; // ingreso
  cuenta: any;

  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private s_documentos: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private movService: MovimientoService,
    private artimoviService: ArtimoviService,
    private cueService: CuentasService,
  ) { }

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
      return;
    }

    sessionStorage.setItem('ventana', '/mov-ingresos');

    const coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    this.formMovimiento = this.fb.group({
      numero: [
        0,
        [Validators.required, Validators.min(1), Validators.pattern(/^[1-9]\d*$/)],
      ],
      fecha: [this.today.toISOString().substring(0, 10), [Validators.required]],
      numentrada: ['', [Validators.required, Validators.minLength(2)]],

      // Total solo lectura (se recalcula)
      total: ['0.00'],

      numart: [''],
      numdoc: ['', [Validators.required, Validators.minLength(3)]],
      documento: [null, [Validators.required]],
      fecdoc: [this.today.toISOString().substring(0, 10), [Validators.required]],

      swaprobado: [false],

      beneficiarioText: ['', [Validators.required]],
      destinoText: ['', [Validators.required]],

      beneficiario: [null, Validators.required],
      destino: [null, Validators.required],

      compegre: ['', Validators.required],
      observaciones: [''],
    });

    this.formArticuloAdd = this.fb.group(
      {
        codigo: ['', [Validators.required, Validators.minLength(1)]],
        nombre: ['', [Validators.required, Validators.minLength(2)]],

        codcue: ['', [Validators.required, Validators.minLength(2)]],
        nomcue: [{ value: '', disabled: false }], // readonly en HTML, pero puede estar enabled igual
        cuenta: [null], // ✅ IMPORTANTE: para guardar el objeto cuenta

        unidad: [''],
        actual: [0, [Validators.required, Validators.min(0)]],
        cosactual: [0, [Validators.required, Validators.min(0)]],
        descripcion: [''],
        cantidad: [1, [Validators.required, Validators.min(1)]],
      });


    this.formArticuloAdd.addControl('inicial', this.fb.control(0, [Validators.min(0)]));
    this.formArticuloAdd.addControl('cosinicial', this.fb.control(0, [Validators.min(0)]));
    this.formArticuloAdd.addControl('costotal', this.fb.control({ value: '0.00', disabled: false }));

    this.formArticuloAdd.get('cosactual')?.valueChanges.subscribe(() => this.actualizarTotalModal());
    this.formArticuloAdd.get('cantidad')?.valueChanges.subscribe(() => this.actualizarTotalModal());


    this.getAllDocumentos();
    this.getAllDestinos();
    this.getLastNumeroMovimiento();

    this.recalcularTotalMovimiento();
  }

  // ======================
  // Helpers
  // ======================
  get f() {
    return this.formMovimiento.controls;
  }
  get formArticuloAddControls() {
    return this.formArticuloAdd.controls;
  }
  get a() {
    return this.formArticuloAdd.controls;
  }

  private actualizarTotalModal(): void {
    const cos = Number(this.formArticuloAdd.get('cosactual')?.value ?? 0);
    const cant = Number(this.formArticuloAdd.get('cantidad')?.value ?? 0);
    const total = cos * cant;

    this.formArticuloAdd.get('costotal')?.setValue(total.toFixed(2), { emitEvent: false });
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    const cabecera = document.querySelector('.cabecera');
    if (cabecera) cabecera.classList.add('nuevoBG1');

    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    const detalle = document.querySelector('.detalle');
    if (detalle) detalle.classList.add('nuevoBG2');
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

  // ======================
  // Guardar Movimiento
  // ======================
  guardar() {
    this.formMovimiento.markAllAsTouched();

    if (this.formMovimiento.invalid) {
      this.swal('warning', 'Complete los campos obligatorios.');
      return;
    }

    if (!this._articulosSelected || this._articulosSelected.length === 0) {
      this.swal('warning', 'Debe agregar al menos un artículo.');
      return;
    }

    const f = this.formMovimiento.value;

    const totalDetalle = this._articulosSelected.reduce(
      (acc, x) => acc + (Number(x.articulo?.cosactual ?? 0) * Number(x.cantidad ?? 0)),
      0
    );

    const cantidadTotal = this._articulosSelected.reduce(
      (acc, x) => acc + Number(x.cantidad ?? 0),
      0
    );

    // 1) Cabecera movimiento
    const movimiento: Movimientos = new Movimientos();
    movimiento.tipmov = this.tipmov;
    movimiento.numero = f.numero;
    movimiento.fecha = f.fecha;
    movimiento.numentrada = f.numentrada;

    movimiento.total = totalDetalle;                 // recomendado
    movimiento.numart = this._articulosSelected.length;

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

    this.movService.saveMovimientoAsync(movimiento)
      .then(async (movimientoGuardado: any) => {

        const idMovimiento =
          movimientoGuardado?.idmovimiento ??
          movimientoGuardado?.id ??
          movimientoGuardado;
        console.log(this.formMovimiento.get('total')?.value);
        // 2) Payload para /artimovi/guardar-artimovi (lo que TU backend valida)
        const artimoviPayload: any = {
          tipmov: this.tipmov,
          total: totalDetalle,
          cantidad: cantidadTotal,
          cosprom: 0,
          costo: this.formMovimiento.get('total')?.value || 0,
          usucrea: this.authService.idusuario,
          feccrea: new Date(),
          movimiento: { idmovimiento: idMovimiento },
          articulos: this._articulosSelected.map((x) => ({
            // artículos nuevos SIN id
            codigo: x.articulo?.codigo,
            nombre: x.articulo?.nombre,
            codcue: x.articulo?.codcue,
            unidad: x.articulo?.unidad,
            inicial: x.articulo?.inicial,
            cosinicial: x.articulo?.cosinicial,
            actual: x.articulo?.actual,
            cosactual: x.articulo?.cosactual,
            costotal: x.articulo?.costotal,
            descripcion: x.articulo?.descripcion,
            minimo: x.articulo?.minimo,
            maximo: x.articulo?.maximo,
            swinmediato: x.articulo?.swinmediato,
            cuenta: this.cuenta,
            usucrea: this.authService.idusuario,
            feccrea: new Date(),
          })),
          usumodi: this.authService.idusuario,
          fecmodi: null,
        };
        await this.artimoviService.saveArtimoviAsync(artimoviPayload);
        return movimientoGuardado;
      })
      .then((movimientoGuardado: any) => {
        this.swal('success', `El ingreso N° ${movimientoGuardado.numero} se ha guardado correctamente.`);
        this.regresar();
      })
      .catch((err: any) => {
        // 🔥 Esto te mostrará el motivo real del 400
        console.error('ERROR status:', err?.status);
        console.error('ERROR body:', err?.error);
        console.error('ERROR full:', err);

        this.authService.mostrarError('error', err?.error || 'Error al guardar');
      });
  }


  regresar() {
    this.router.navigate(['/mov-ingresos']);
  }

  // ======================
  // Número disponible
  // ======================
  numAvailable(event: any) {
    const num = event?.target?.value;
    if (!num) return;

    this.movService.getNumAvailable(this.tipmov, +num).subscribe({
      next: (disponible: boolean) => {
        const numeroControl = this.formMovimiento.get('numero');
        if (!disponible) {
          numeroControl?.setErrors({ notAvailable: true });
        } else {
          if (numeroControl?.hasError('notAvailable')) {
            numeroControl.setErrors(null);
          }
        }
      },
      error: (err) => console.error('Error verificando número:', err),
    });
  }

  getLastNumeroMovimiento() {
    this.movService.findUltimo(this.tipmov).subscribe({
      next: (data: number) => {
        this.formMovimiento.patchValue({ numero: data + 1 });
      },
    });
  }

  // ======================
  // Documentos
  // ======================
  getAllDocumentos() {
    this.s_documentos.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        this._documentos = data;
        if (data && data.length > 0) this.formMovimiento.patchValue({ documento: data[0] });
      },
      error: (e) => console.error(e.error),
    });
  }

  // ======================
  // Destinos
  // ======================
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

  onDestinoTyped(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;
    this.formMovimiento.patchValue({ destino: dest });
  }

  onDestinoSelected(ev: any) {
    const key = (ev.target.value || '').trim().toLowerCase();
    const dest = this._destinos?.find((d) => d.nomdestino?.toLowerCase() === key) || null;

    if (dest) {
      this.formMovimiento.patchValue({ destino: dest, destinoText: dest.nomdestino });
    } else {
      this.formMovimiento.patchValue({ destino: null });
    }

    this.formMovimiento.get('destino')?.markAsTouched();
  }

  // ======================
  // Beneficiarios
  // ======================
  onBeneficiarioTyped(ev: any) {
    const raw = (ev?.target?.value || '').trim();
    const key = raw.toLowerCase();

    this.formMovimiento.patchValue({ beneficiario: null });

    this.getAllBeneficiarios(raw, (lista) => {
      const bene = lista.find((b) => (b.nomben || '').toLowerCase() === key) || null;
      if (bene) {
        setTimeout(() => {
          this.formMovimiento.patchValue({ beneficiario: bene, beneficiarioText: bene.nomben });
        });
      }
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
          beneficiarioText: b ? b.nomben : raw,
        });
        this.formMovimiento.get('beneficiario')?.markAsTouched();
      });
      return;
    }

    this.formMovimiento.patchValue({ beneficiario: bene, beneficiarioText: bene.nomben });
    this.formMovimiento.get('beneficiario')?.markAsTouched();
  }

  getAllBeneficiarios(query: string, onLoaded?: (lista: Beneficiarios[]) => void): void {
    const nombreVal = query?.trim();
    if (!nombreVal) {
      this._beneficiarios = [];
      onLoaded?.([]);
      return;
    }

    this.beneService.findByPrefixAndNombre('P', nombreVal).subscribe({
      next: (data: Beneficiarios[] = []) => {
        this._beneficiarios = Array.isArray(data) ? data : [];
        onLoaded?.(this._beneficiarios);
      },
      error: () => {
        this._beneficiarios = [];
        onLoaded?.([]);
      },
    });
  }

  // ======================
  // Modal Artículo (sin JS manual, porque lo cierras con data-bs-dismiss)
  // ======================
  openArticuloModal(): void {
    // si quisieras abrir por TS, aquí; pero con data-bs-toggle no hace falta
    this.formArticuloAdd.reset({
      codigo: '',
      nombre: '',
      codcue: '',
      unidad: '',
      actual: 0,
      cosactual: 0,
      descripcion: '',
      cantidad: 1,
    });
  }

  // ===== AGREGAR ARTÍCULO A TABLA =====
  addArticuloFromModal(): void {
    if (this.formArticuloAdd.invalid) return;

    const v = this.formArticuloAdd.value;

    const articulo: Articulos = {
      idarticulo: 0,
      codigo: (v.codigo ?? '').trim(),
      nombre: (v.nombre ?? '').trim(),
      codcue: (v.codcue ?? '').trim(),
      unidad: (v.unidad ?? '').trim(),
      inicial: 0,
      cosinicial: 0,
      actual: Number(v.actual ?? 0),
      cosactual: Number(v.cosactual ?? 0),
      costotal: 0,
      descripcion: (v.descripcion ?? '').trim(),
      minimo: undefined,
      maximo: undefined,
      swinmediato: false,
      usucrea: this.authService.idusuario || 0,
      feccrea: new Date(),
      usumodi: undefined,
      fecmodi: undefined,
      cuenta: null as any,
    };

    const cantidad = Number(v.cantidad ?? 1);
    const costotal = articulo.cosactual * cantidad;

    // Evitar duplicados por código (puedes cambiar a idarticulo cuando exista)
    const exists = this._articulosSelected.some(
      (x) => (x.articulo.codigo || '').trim().toLowerCase() === articulo.codigo.trim().toLowerCase()
    );

    if (exists) {
      this.swal('warning', 'Ese artículo ya está agregado.');
      return;
    }

    this._articulosSelected.push({ articulo, cantidad, costotal });

    this.recalcularTotalMovimiento();

    // Limpia para la siguiente vez
    this.formArticuloAdd.reset({
      codigo: '',
      nombre: '',
      codcue: '',
      unidad: '',
      actual: 0,
      cosactual: 0,
      descripcion: '',
      cantidad: 1,
    });
  }

  validarCantidadRow(row: ArticuloMovimiento): void {
    if (row.cantidad < 1) row.cantidad = 1;
    if (row.cantidad > row.articulo.actual) row.cantidad = row.articulo.actual;

    row.costotal = Number(row.articulo.cosactual) * Number(row.cantidad);
    this.recalcularTotalMovimiento();
  }

  removeArticulo(i: number): void {
    this._articulosSelected.splice(i, 1);
    this.recalcularTotalMovimiento();
  }

  recalcularTotalMovimiento(): void {
    const total = this._articulosSelected.reduce(
      (acc, x) => acc + (Number(x.articulo.cosactual) * Number(x.cantidad)),
      0
    );
    this.formMovimiento.patchValue({ total: total.toFixed(2) }, { emitEvent: false });
  }
  validarCuentaCodcue(ev?: any): void {
    const ctrl = this.formArticuloAdd.get('codcue');
    const raw = (ev?.target?.value ?? ctrl?.value ?? '').toString().trim();

    // si está vacío: opcional (si NO es requerido, quitamos errores)
    if (!raw) {
      ctrl?.setErrors(null);
      this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false }); // si manejas cuenta en el form
      return;
    }

    // Limpia error anterior "cuentaNoExiste" mientras consulta
    if (ctrl?.hasError('cuentaNoExiste')) {
      const { cuentaNoExiste, ...rest } = ctrl.errors || {};
      ctrl.setErrors(Object.keys(rest).length ? rest : null);
    }

    // ✅ Consulta backend (ajusta al nombre real de tu servicio)
    this.cueService.findByCodcue(raw).subscribe({
      next: (cuentaEncontrada: any) => {
        if (!cuentaEncontrada) {
          ctrl?.setErrors({ ...(ctrl.errors || {}), cuentaNoExiste: true });
          this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
          return;
        }

        // ✅ existe: guardas el objeto cuenta en el form si quieres
        this.formArticuloAdd.patchValue({ cuenta: cuentaEncontrada }, { emitEvent: false });

        // quita error cuentaNoExiste si estaba
        const errors = ctrl?.errors || null;
        if (errors && errors['cuentaNoExiste']) {
          const { cuentaNoExiste, ...rest } = errors;
          ctrl?.setErrors(Object.keys(rest).length ? rest : null);
        }
      },
      error: () => {
        // Si falla la consulta, puedes marcar error genérico
        ctrl?.setErrors({ ...(ctrl.errors || {}), cuentaNoExiste: true });
        this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
      }
    });
  }

  getCuentaByCodigo(e: any): void {
    const ctrlCod = this.formArticuloAdd.get('codcue');
    const ctrlNom = this.formArticuloAdd.get('nomcue');

    const codcue = (e?.target?.value ?? '').toString().trim();

    // Si está vacío
    if (!codcue) {
      ctrlCod?.setErrors({ required: true });
      ctrlNom?.setValue('', { emitEvent: false });
      this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
      return;
    }

    // Marca como tocado para que se vea la validación
    ctrlCod?.markAsTouched();

    // Limpia error cuentaNoExiste mientras busca
    if (ctrlCod?.hasError('cuentaNoExiste')) {
      const { cuentaNoExiste, ...rest } = ctrlCod.errors || {};
      ctrlCod.setErrors(Object.keys(rest).length ? rest : null);
    }

    this.cueService.findByCodcue(codcue).subscribe({
      next: (cuenta: any) => {
        // Si tu API devuelve null/undefined cuando no encuentra:
        if (!cuenta) {
          ctrlCod?.setErrors({ ...(ctrlCod.errors || {}), cuentaNoExiste: true });
          ctrlNom?.setValue('', { emitEvent: false });
          this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
          return;
        }

        // ✅ Existe
        ctrlNom?.setValue(cuenta.nomcue ?? '', { emitEvent: false });
        this.formArticuloAdd.patchValue({ cuenta: cuenta }, { emitEvent: false });
        this.cuenta = cuenta;
        // Quita error cuentaNoExiste si estaba
        const errors = ctrlCod?.errors || null;
        if (errors && errors['cuentaNoExiste']) {
          const { cuentaNoExiste, ...rest } = errors;
          ctrlCod?.setErrors(Object.keys(rest).length ? rest : null);
        }
      },
      error: () => {
        // Si falla, se maneja como no encontrada
        ctrlCod?.setErrors({ ...(ctrlCod.errors || {}), cuentaNoExiste: true });
        ctrlNom?.setValue('', { emitEvent: false });
        this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
      },
    });
  }

}

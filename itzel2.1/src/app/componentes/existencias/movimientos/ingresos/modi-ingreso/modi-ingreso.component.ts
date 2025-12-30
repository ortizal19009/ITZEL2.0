import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { Documentos } from '../../../../modelos/administracion/documentos.model';
import { DocumentosService } from '../../../../servicios/administracion/documentos.service';
import { Destinos } from '../../../../modelos/existencias/destinos.model';
import { DestinosService } from '../../../../servicios/existencias/destinos.service';
import { Beneficiarios } from '../../../../modelos/contabilidad/beneficiarios.model';
import { BeneficiariosService } from '../../../../servicios/contabilidad/beneficiarios.service';
import { MovimientoService } from '../../../../servicios/existencias/movimiento.service';
import { Movimientos } from '../../../../modelos/existencias/movimientos.model';
import { Articulos } from '../../../../modelos/existencias/articulos.model';
import { CuentasService } from '../../../../servicios/contabilidad/cuentas.service';
import { ArtimoviService } from '../../../../servicios/existencias/artimovi.service';

export interface ArticuloMovimiento {
  articulo: Articulos;
  cantidad: number;
  costotal: number; // cosactual * cantidad
}

@Component({
  selector: 'app-modi-ingreso.component',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './modi-ingreso.component.html',
  styleUrl: './modi-ingreso.component.css',
})
export class ModiIngresoComponent implements OnInit {
  today: Date = new Date();

  formMovimiento!: FormGroup;
  formArticuloAdd!: FormGroup;

  _documentos: Documentos[] = [];
  _destinos: Destinos[] = [];
  _beneficiarios: Beneficiarios[] = [];

  _articulosSelected: ArticuloMovimiento[] = [];

  tipmov: number = 1; // ingreso
  cuenta: any;

  private idmovimiento!: number;

  constructor(
    private router: Router,
    private fb: FormBuilder,
    public authService: AutorizaService,
    private s_documentos: DocumentosService,
    private beneService: BeneficiariosService,
    private destService: DestinosService,
    private movService: MovimientoService,
    private cueService: CuentasService,
    private artimoviService: ArtimoviService
  ) { }

  ngOnInit(): void {
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
      return;
    }

    sessionStorage.setItem('ventana', '/mov-ingresos');

    // ✅ id a modificar (viene del listado)
    const idmov = Number(sessionStorage.getItem('idToModIngMovimientos') || 0);
    if (!idmov) {
      this.swal('warning', 'No se encontró el movimiento a modificar.');
      this.regresar();
      return;
    }
    this.idmovimiento = idmov;

    const coloresJSON = sessionStorage.getItem('/mov-ingresos');
    if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));

    // ✅ Form cabecera
    this.formMovimiento = this.fb.group({
      idmovimiento: [''],
      numero: [0, [Validators.required, Validators.min(1), Validators.pattern(/^[1-9]\d*$/)]],
      fecha: [this.today.toISOString().substring(0, 10), [Validators.required]],
      numentrada: ['', [Validators.required, Validators.minLength(2)]],

      // total recalculado
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
      usucrea: [''],
      feccrea: [''],
      usumodi: [''],
      fecmodi: [''],
    });

    // ✅ Form modal artículo
    this.formArticuloAdd = this.fb.group({
      codigo: ['', [Validators.required, Validators.minLength(1)]],
      nombre: ['', [Validators.required, Validators.minLength(2)]],

      codcue: ['', [Validators.required, Validators.minLength(2)]],
      nomcue: [{ value: '', disabled: false }],
      cuenta: [null],
      inicial: [0],
      cosinicial: [0],
      costotal: [0],
      unidad: [''],
      actual: [0, [Validators.required, Validators.min(0)]],
      cosactual: [0, [Validators.required, Validators.min(0)]],
      descripcion: [''],
      cantidad: [1, [Validators.required, Validators.min(1)]],
    });

    // Cargas generales
    this.getAllDocumentos();
    this.getAllDestinos();

    // ✅ carga cabecera + detalle
    this.getMovimientoById(this.idmovimiento);
    this.getArtiMoviByIdMovimiento(this.idmovimiento);
  }

  // ======================
  // Helpers
  // ======================
  get f() {
    return this.formMovimiento.controls;
  }
  get a() {
    return this.formArticuloAdd.controls;
  }
  get formArticuloAddControls() {
    return this.formArticuloAdd.controls;
  }

  colocaColor(colores: any) {
    document.documentElement.style.setProperty('--bgcolor1', colores[0]);
    document.querySelector('.cabecera')?.classList.add('nuevoBG1');

    document.documentElement.style.setProperty('--bgcolor2', colores[1]);
    document.querySelector('.detalle')?.classList.add('nuevoBG2');
  }

  swal(icon: any, mensaje: any) {
    Swal.fire({
      toast: true,
      icon,
      title: mensaje,
      position: 'top',
      showConfirmButton: false,
      timer: 2000,
    });
  }

  regresar() {
    this.router.navigate(['/mov-ingresos']);
  }

  // ======================
  // Cargar data
  // ======================
  getAllDocumentos() {
    this.s_documentos.getListaDocumentos().subscribe({
      next: (data: Documentos[]) => {
        this._documentos = data || [];
        // en edición NO forzamos el primero si ya se setea al cargar el movimiento
      },
      error: (e) => console.error(e?.error || e),
    });
  }

  getAllDestinos() {
    this.destService.getListaDestinos().subscribe({
      next: (data: Destinos[]) => {
        this._destinos = data || [];
      },
      error: (e) => this.authService.mostrarError('error', e?.error || 'Error cargando destinos'),
    });
  }

  getMovimientoById(id: number) {
    this.movService.getMovimientoById(id).subscribe({
      next: (data: Movimientos) => {
        this.formMovimiento.setValue({
          idmovimiento: data.idmovimiento,
          numero: data.numero,
          fecha: new Date(data.fecha as any).toISOString().substring(0, 10),
          numentrada: data.numentrada,

          total: (Number(data.total ?? 0)).toFixed(2),
          numart: data.numart ?? 0,

          numdoc: data.numdoc,
          documento: data.documento,
          fecdoc: new Date(data.fecdoc as any).toISOString().substring(0, 10),
          swaprobado: data.swaprobado,

          beneficiario: data.beneficiario,
          destino: data.destino,
          beneficiarioText: data.beneficiario ? data.beneficiario.nomben : '',
          destinoText: data.destino ? data.destino.nomdestino : '',

          compegre: data.compegre,
          observaciones: data.observaciones ?? '',
          usucrea: data.usucrea,
          feccrea: data.feccrea,
          usumodi: this.authService.idusuario,
          fecmodi: new Date().toISOString().substring(0, 10),
        });
      },
      error: (e) => console.error(e?.error || e),
    });
  }

  /**
   * ✅ Carga el detalle desde backend y lo transforma a tu tabla local.
   * Ajusta los nombres si tu API devuelve distinto (articulo vs articulos, etc.)
   */
  getArtiMoviByIdMovimiento(idmovimiento: number) {
    this.artimoviService.getByIdMovimiento(idmovimiento).subscribe({
      next: (data: any[] = []) => {
        console.log('Detalle artimovi cargado:', data);
        // Esperado: [{ articulo: {...}, cantidad: X, costo: Y, total: Z, ... }, ...]
        this._articulosSelected = (data || []).map((d: any) => {
          const art: Articulos = d.articulo ?? d.articulos ?? d.articuloDTO ?? d;
          const cantidad = Number(d.cantidad ?? 0);
          const cosUnit = Number(art?.cosactual ?? d.costo ?? 0);
          return {
            articulo: art,
            cantidad,
            costotal: cosUnit * cantidad,
          };
        });

        this.recalcularTotalMovimiento();
      },
      error: (e) => console.error(e?.error || e),
    });
  }

  // ======================
  // Autocomplete destinos/beneficiarios (igual que tu AddIngreso)
  // ======================
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

  compareDocumentos(o1: Documentos, o2: Documentos): boolean {
    // Si ambos son null o undefined, se consideran iguales
    if (o1 === null || o2 === null) return o1 === o2;
    // Comparamos por id (o por el campo que identifique al documento)
    return o1.iddocumento === o2.iddocumento;
  }

  // ======================
  // Tabla detalle: total, add, remove, validar
  // ======================
  recalcularTotalMovimiento(): void {
    const total = this._articulosSelected.reduce(
      (acc, x) => acc + Number(x.articulo?.cosactual ?? 0) * Number(x.cantidad ?? 0),
      0
    );
    this.formMovimiento.patchValue(
      { total: total.toFixed(2), numart: this._articulosSelected.length },
      { emitEvent: false }
    );
  }

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
    const costotal = Number(articulo.cosactual) * cantidad;

    const exists = this._articulosSelected.some(
      (x) => (x.articulo.codigo || '').trim().toLowerCase() === articulo.codigo.trim().toLowerCase()
    );

    if (exists) {
      this.swal('warning', 'Ese artículo ya está agregado.');
      return;
    }

    this._articulosSelected.push({ articulo, cantidad, costotal });
    this.recalcularTotalMovimiento();

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
/*     if (row.cantidad < 1) row.cantidad = 1;
    if (row.cantidad > row.articulo.actual) row.cantidad = row.articulo.actual; */

    row.costotal = Number(row.articulo.cosactual ?? 0) * Number(row.cantidad);
    this.recalcularTotalMovimiento();
  }

  removeArticulo(i: number): void {
    this._articulosSelected.splice(i, 1);
    this.recalcularTotalMovimiento();
  }

  // ======================
  // Cuenta por código (igual que tu versión)
  // ======================
  getCuentaByCodigo(e: any): void {
    const ctrlCod = this.formArticuloAdd.get('codcue');
    const ctrlNom = this.formArticuloAdd.get('nomcue');

    const codcue = (e?.target?.value ?? '').toString().trim();

    if (!codcue) {
      ctrlCod?.setErrors({ required: true });
      ctrlNom?.setValue('', { emitEvent: false });
      this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
      return;
    }

    ctrlCod?.markAsTouched();

    if (ctrlCod?.hasError('cuentaNoExiste')) {
      const { cuentaNoExiste, ...rest } = ctrlCod.errors || {};
      ctrlCod.setErrors(Object.keys(rest).length ? rest : null);
    }

    this.cueService.findByCodcue(codcue).subscribe({
      next: (cuenta: any) => {
        if (!cuenta) {
          ctrlCod?.setErrors({ ...(ctrlCod.errors || {}), cuentaNoExiste: true });
          ctrlNom?.setValue('', { emitEvent: false });
          this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
          return;
        }

        ctrlNom?.setValue(cuenta.nomcue ?? '', { emitEvent: false });
        this.formArticuloAdd.patchValue({ cuenta }, { emitEvent: false });
        this.cuenta = cuenta;

        const errors = ctrlCod?.errors || null;
        if (errors && errors['cuentaNoExiste']) {
          const { cuentaNoExiste, ...rest } = errors;
          ctrlCod?.setErrors(Object.keys(rest).length ? rest : null);
        }
      },
      error: () => {
        ctrlCod?.setErrors({ ...(ctrlCod.errors || {}), cuentaNoExiste: true });
        ctrlNom?.setValue('', { emitEvent: false });
        this.formArticuloAdd.patchValue({ cuenta: null }, { emitEvent: false });
      },
    });
  }

  numAvailable(event: any) {
    const num = event?.target?.value;
    if (!num) return;

    // Si estás editando, no marques error si el número es el mismo del movimiento actual
    const actual = this.formMovimiento.get('numero')?.value;
    if (+num === +actual) return;

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


  // ======================
  // Guardar edición (cabecera + detalle)
  // ======================
  guardar() {
    this.formMovimiento.markAllAsTouched();

    if (this.formMovimiento.invalid) {
      this.swal('warning', 'Complete los campos obligatorios.');
      return;
    }

    if (!this._articulosSelected.length) {
      this.swal('warning', 'Debe agregar al menos un artículo.');
      return;
    }

    const f = this.formMovimiento.value;

    const totalDetalle = this._articulosSelected.reduce(
      (acc, x) => acc + Number(x.articulo?.cosactual ?? 0) * Number(x.cantidad ?? 0),
      0
    );

    const cantidadTotal = this._articulosSelected.reduce((acc, x) => acc + Number(x.cantidad ?? 0), 0);

    const movimiento: Movimientos = new Movimientos();
    movimiento.idmovimiento = Number(f.idmovimiento);
    movimiento.tipmov = this.tipmov;
    movimiento.numero = f.numero;
    movimiento.fecha = f.fecha;
    movimiento.numentrada = f.numentrada;

    movimiento.total = totalDetalle;
    movimiento.numart = this._articulosSelected.length;

    movimiento.documento = f.documento;
    movimiento.numdoc = f.numdoc;
    movimiento.fecdoc = f.fecdoc;
    movimiento.swaprobado = f.swaprobado;

    movimiento.beneficiario = f.beneficiario;
    movimiento.destino = f.destino;

    movimiento.compegre = f.compegre;
    movimiento.observaciones = f.observaciones;
    movimiento.usucrea = f.usucrea;
    movimiento.feccrea = f.feccrea;

    movimiento.usumodi = this.authService.idusuario;
    movimiento.fecmodi = new Date();

    this.movService.updateMovimiento(movimiento).subscribe({
      next: async () => {
        try {
          await this.actualizarDetalleArtimovi(movimiento.idmovimiento!, totalDetalle, cantidadTotal);
          this.swal('success', 'Ingreso actualizado correctamente.');
          this.regresar();
        } catch (e: any) {
          console.error(e);
          this.authService.mostrarError('error', e?.error || 'Error actualizando detalle');
        }
      },
      error: (e) => {
        console.error(e);
        this.authService.mostrarError('error', e?.error || 'Error al actualizar');
      },
    });
  }

  /**
   * ✅ Estrategia simple: borrar detalle anterior y volver a insertar.
   * Requiere un endpoint delete por idmovimiento.
   *
   * Si no lo tienes aún, crea:
   * DELETE /artimovi/por-movimiento/{idmovimiento}
   */
  private async actualizarDetalleArtimovi(idMovimiento: number, totalDetalle: number, cantidadTotal: number) {
    // 1) borrar detalle anterior
    if (this.artimoviService.deleteByMovimientoAsync) {
      await this.artimoviService.deleteByMovimientoAsync(idMovimiento);
    } else {
      // Si aún no tienes este método, igual puedes continuar,
      // pero se duplicarán registros si el backend guarda detalle por item.
      console.warn('⚠️ No existe deleteByMovimientoAsync en ArtimoviService; podrías duplicar detalle.');
    }

    // 2) insertar detalle nuevo con el MISMO payload del add
    const payload: any = {
      tipmov: this.tipmov,
      total: totalDetalle,
      cantidad: cantidadTotal,
      cosprom: 0,
      costo: totalDetalle, // ✅ evita null y pasa validación
      usucrea: this.authService.idusuario,
      feccrea: new Date(),
      movimiento: { idmovimiento: idMovimiento },
      articulos: this._articulosSelected.map((x) => ({
        // ideal: si tienes idarticulo, mándalo para NO duplicar
        idarticulo: x.articulo?.idarticulo,
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
      fecmodi: new Date(),
    };

    await this.artimoviService.saveArtimoviAsync(payload);
  }
}

import { ChangeDetectorRef, Component } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import Swal from 'sweetalert2';
import { PresupuestoService } from '../../../../servicios/contabilidad/presupuesto.service';
import { ServerConfigService } from '../../../../servicios/config/server-config.service';
import { CommonModule, Location } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AutorizaService } from '../../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../../servicios/administracion/colores.service';

@Component({
  selector: 'app-info-gasto',
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './info-gasto.component.html',
  styleUrl: './info-gasto.component.css',
})
export class InfoGastoComponent {
  title: string = 'Detalles partida gasto ';
  stringFilter!: string;
  _pgasto: any = {
    nompar: '',
    codigo: '',
    codpar: '',
    idproyecto: {},
    idclasificador: {},
    inicia: 0,
    totcerti: 0,
    totdeven: 0,
    totmod: 0,
    feccrea: null,
  };
  _idpartida?: number;

  constructor(
    private _params: ActivatedRoute,
    private serverConfigService: ServerConfigService,
    private presupuestoService: PresupuestoService,
    private location: Location,
    public authService: AutorizaService,
    private coloresService: ColoresService,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {}
  ngOnInit(): void {
    const codigoParam = this._params.snapshot.paramMap.get('idpresupuesto');
    if (codigoParam) {
      this._idpartida = +codigoParam!;
      this.getPresupuestoById(this._idpartida);
    } else {
      console.warn('No se encontró el parámetro "codigo" en la ruta.');
      this.swal('error', 'No se encontró el parámetro "codigo" en la ruta.');
    }
    if (!this.authService.sessionlog) {
      this.router.navigate(['/inicio']);
    }

    if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
      sessionStorage.setItem('ventana', '/info-gasto');
      let coloresJSON = sessionStorage.getItem('/info-gasto');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();
    } else {
      console.warn('sessionStorage no disponible (SSR o entorno server)');
      // Opcional: inicializa valores por defecto si quieres
    }
    this.serverConfigService.currentFilter.subscribe((filterValue: any) => {
      this.stringFilter = filterValue;
    });
  }
  async buscaColor() {
    try {
      const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'info-gasto');
      const coloresJSON = JSON.stringify(datos);
      sessionStorage.setItem('/info-gasto', coloresJSON);
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
  volver(): void {
    this.location.back();
  }

  getPresupuestoById(idpresupuesto: number) {
    this.presupuestoService.findById(idpresupuesto).subscribe({
      next: (presupuesto: any) => {
        this._pgasto = presupuesto;
        this.cdr.detectChanges(); // 👈 fuerza la actualización en la vista
      },
      error: (e: any) => {
        console.error(e);
        this.swal('error', 'Error al obtener presupuesto');
      },
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

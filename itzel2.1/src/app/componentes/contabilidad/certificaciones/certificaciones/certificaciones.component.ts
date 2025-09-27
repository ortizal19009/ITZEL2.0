import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import { CertificacionesService } from '../../../servicios/contabilidad/certificaciones.service';
import { Certificaciones } from '../../../modelos/contabilidad/certificaciones.model';

@Component({
  selector: 'app-certificaciones.component',
  imports: [RouterLink, CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './certificaciones.component.html',
  styleUrl: './certificaciones.component.css',
})
export class CertificacionesComponent implements OnInit {

   formBuscar!: FormGroup;
   swbuscando?: boolean;
   txtbuscar: string = 'Buscar';
   certiFiltradas: any[] = [];
   _certificaciones: any[] = [];
   ordenColumna: keyof CertificacionVisual = 'numero';
   ordenAscendente: boolean = true;
   today = new Date().toISOString().substring(0, 10); // ejemplo: "2025-09-19"
   sumTotal = 0;

   constructor(private router: Router, private fb: FormBuilder, public authService: AutorizaService,
      private coloresService: ColoresService, private elimService: EliminadosService, private certiService: CertificacionesService) { }

   ngOnInit(): void {
      if (!this.authService.sessionlog) { this.router.navigate(['/inicio']); }
      const date = new Date();
      date.setDate(date.getDate() - 30);

      if (typeof window !== 'undefined' && typeof sessionStorage !== 'undefined') {
         sessionStorage.setItem('ventana', '/certificaciones');
         let coloresJSON = sessionStorage.getItem('/certificaciones');
         if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
         else this.buscaColor();
      } else {
         console.warn('sessionStorage no disponible (SSR o entorno server)');
      }
      this.formBuscar = this.fb.group({
         min: '',
         max: '',
         fechaInicio: date.toISOString().substring(0, 10),
         fechaFin: [this.today],
         filtroControl: '',
      });

      this.getLastCertificacion();

      this.formBuscar.get('filtroControl')?.valueChanges.subscribe((valor: any) => { this.filtrar(valor) });
   }

   async buscaColor() {
      try {
         const datos = await this.coloresService.setcolor(this.authService.idusuario!, 'certificaciones');
         const coloresJSON = JSON.stringify(datos);
         sessionStorage.setItem('/certificaciones', coloresJSON);
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

   getLastCertificacion() {
      this.certiService.findLastByTipo(1).subscribe({
         next: (certificacion: Certificaciones) => {
            let minimo = certificacion.numero - 20;
            if (minimo <= 0) {
               minimo = 1;
            }
            this.formBuscar.patchValue({
               min: minimo,
               max: certificacion.numero,
            });
            this.buscar();
         },
      });
   }

   buscar() {
      let f = this.formBuscar.value;
      this.certiService.getByNumDate(1, f.fechaInicio, f.fechaFin, f.min, f.max).subscribe({
         next: (datos: Certificaciones[]) => {
         console.log(datos);
            if (datos.length === 0) {
               this.authService.mostrarError('No se encontraron registros', 'Atención');
            }
            this._certificaciones = datos;
            this.certiFiltradas = [...datos];
            this.calcTotales();
         },
         error: (e: any) => console.error(e.error),
      });
   }

   calcTotales(): void {
      this.sumTotal = 0;
      for (const certi of this.certiFiltradas) { this.sumTotal += certi.valor || 0; }
   }

   ordenarPor(campo: keyof CertificacionVisual): void {
      if (this.ordenColumna === campo) {
         this.ordenAscendente = !this.ordenAscendente;
      } else {
         this.ordenColumna = campo;
         this.ordenAscendente = true;
      }

      this.certiFiltradas.sort((a: any, b: any) => {
         let valorA: any;
         let valorB: any;
         switch (campo) {
            case 'documentonum':
               valorA = `${a.documento.nomdoc}.${a.numdoc}`;
               valorB = `${b.documento.nomdoc}.${b.numdoc}`;
               break;
            case 'beneficiario':
               valorA = a.beneficiario?.nomben;
               valorB = b.beneficiario?.nomben;
               break;
            case 'responsable':
               valorA = a.beneficiariores?.nomben;
               valorB = b.beneficiariores?.nomben;
               break;
            default:
               valorA = a[campo];
               valorB = b[campo];
               break;
         }
         if (valorA == null && valorB == null) return 0;
         if (valorA == null) return 1;
         if (valorB == null) return -1;

         const esNumero = typeof valorA === 'number' && typeof valorB === 'number';

         if (esNumero) {
            return this.ordenAscendente ? valorA - valorB : valorB - valorA;
         } else {
            return this.ordenAscendente
               ? String(valorA).localeCompare(String(valorB))
               : String(valorB).localeCompare(String(valorA));
         }
      });
   }

   filtrar(valor: any) {
      const filtro = valor.toLowerCase();
      if (!filtro) {
         if (this.certiFiltradas.length > 0) this.certiFiltradas = [...this._certificaciones];
         this.calcTotales();
         return;
      }
      this.certiFiltradas = this._certificaciones.filter(a => {
         const documentonum = `${a.documento.nomdoc} ${a.numdoc}`;
         const beneficiario = a.beneficiario.nomben;
         const responsable = a.beneficiariores.nomben;
         return [a.numero, documentonum, beneficiario, responsable, a.fecha, a.valor, a.descripcion].some(campo =>
            String(campo).toLowerCase().includes(filtro)
         );
      });
      this.calcTotales();
   }

   nuevo() { this.router.navigate(['/add-certificacion']); }

   cerrar() { this.router.navigate(['/inicio']); }

}

interface CertificacionVisual {
   numero: number;
   fecha: Date;
   documentonum: string;
   beneficiario: string;
   valor: number;
   responsable: string;
   descripcion: string;
}

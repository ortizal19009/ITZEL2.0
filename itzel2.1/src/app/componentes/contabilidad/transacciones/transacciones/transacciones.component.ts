import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { ColoresService } from '../../../servicios/administracion/colores.service';
import { AutorizaService } from '../../../servicios/administracion/autoriza.service';
import { EjecucionService } from '../../../servicios/contabilidad/ejecucion.service';
import { TransaccionesService } from '../../../servicios/contabilidad/transacciones.service';
import { AsientosService } from '../../../servicios/contabilidad/asientos.service';
import { Asientos } from '../../../modelos/contabilidad/asientos.model';
import { Transacciones } from '../../../modelos/contabilidad/transacciones.model';
import { EliminadosService } from '../../../servicios/administracion/eliminados.service';
import Swal from 'sweetalert2';
import { Eliminados } from '../../../modelos/administracion/eliminados.model';

@Component({
  selector: 'app-transacciones.component',
   imports: [ReactiveFormsModule, CommonModule, FormsModule],
  templateUrl: './transacciones.component.html',
  styleUrl: './transacciones.component.css'
})
export class TransaccionesComponent implements OnInit {

   formAsiento!: FormGroup;
   idasiento!: number;
   padre!: string;
   _transacciones: any[] = [];
   concepto!: string;
   _ejecucio: any;
   totDebe!: number;
   totHaber!: number;
   tiptran: string = "0";
   codcue!: String;
   sweliminar: boolean = false;
   idtransaccion!: number;
   swhay!: boolean;
   swejecu: boolean = false;
   actualizar: boolean = false;

   constructor(private fb: FormBuilder, private router: Router, private coloresService: ColoresService, public authService: AutorizaService,
      private asiService: AsientosService, private tranService: TransaccionesService, private ejecuService: EjecucionService,
   private elimService: EliminadosService) { }

   ngOnInit(): void {
      sessionStorage.setItem('ventana', '/transacciones');
      let coloresJSON = sessionStorage.getItem('/transacciones');
      if (coloresJSON) this.colocaColor(JSON.parse(coloresJSON));
      else this.buscaColor();

      this.formAsiento = this.fb.group({
         numero: '',
         comprobante: '',
         fecha: '',
         documentonum: '',
         beneficiario: '',
         // filtroControl: ''
      });

      this.datosAsiento();

      const actuAsiento = sessionStorage.getItem('actuAsiento');  //Regresa de modi-transaccion para actualizar los totales
      sessionStorage.removeItem('actuAsiento');
      if (actuAsiento) { if (actuAsiento == 'true') { this.actualizar = true } else { this.actualizar = false } };
      this.busca(this.actualizar);  //Cuando elimina o modifica (debcre o valor) es true para que actualice totales del asiento
   }

   colocaColor(colores: any) {
      document.documentElement.style.setProperty('--bgcolor1', colores[0]);
      const cabecera = document.querySelector('.cabecera');
      if (cabecera) cabecera.classList.add('nuevoBG1')
      document.documentElement.style.setProperty('--bgcolor2', colores[1]);
      const detalle = document.querySelector('.detalle');
      if (detalle) detalle.classList.add('nuevoBG2');
   }

   async buscaColor() {
      try {
         const datos = await this.coloresService.setcolor(1, 'transacciones');
         const coloresJSON = JSON.stringify(datos);
         sessionStorage.setItem('/transacciones', coloresJSON);
         this.colocaColor(datos);
      } catch (error) {
         console.error(error);
      }
   }

   datosAsiento() {
      let asientoToTran = JSON.parse(sessionStorage.getItem("asientoToTransacciones")!);
      // sessionStorage.removeItem("asientoToTransaci"); OJO: 
      this.idasiento = asientoToTran.idasiento;
      this.padre = asientoToTran.padre;

      this.asiService.obtenerPorIdasiento(this.idasiento).subscribe({
         next: (asiento: Asientos) => {
            let documentonum: string;
            if (asiento.documento.iddocumento == 1) documentonum = asiento.numdoc;
            else documentonum = asiento.documento.nomdoc + ' ' + asiento.numdoc;
            this.formAsiento.patchValue({
               numero: asiento.numero,
               comprobante: codcomprobante(asiento.tipcom) + asiento.compro.toString(),
               fecha: asiento.fecha,
               documentonum: documentonum,
               beneficiario: asiento.beneficiario.nomben,
            });
            this.concepto = asiento.concepto;
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar el Asiento', err.error) }
      });
   }

   busca(actualizar: boolean) {
      this.tranService.obtenerPorIdAsiento(this.idasiento).subscribe({
         next: resp => {
            this._transacciones = resp;
            this.swhay = false;
            if (this._transacciones.length > 0) this.swhay = true;
            this.swejecu = false;
            this.total(actualizar);
            // this.ejecuService.findByIdAsiento(this.idasiento).subscribe({
            //    next: datos => {
            //       this._ejecucio = datos;
            //       if (datos.length > 0) this.swejecu = true;
            //    },
            //    error: err => console.error(err.error)
            // });
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error al buscar Transacciones', err.error); }
      });
   }

   total(actualizar: boolean) {
      let sumDebe: number = 0;
      let sumHaber: number = 0;
      let i = 0;
      this._transacciones.forEach(() => {
         if (this._transacciones[i].debcre == 1) sumDebe += this._transacciones[i].valor;
         else sumHaber += this._transacciones[i].valor;
         i++;
      });
      this.totDebe = Math.round(sumDebe * 100) / 100;
      this.totHaber = Math.round(sumHaber * 100) / 100;
      if (actualizar) {
         // this.asiService.updateTotdebAndTotcre(this.idasiento, +this.totDebe, +this.totHaber).subscribe({
         //    next: () => { },
         //    error: err => {console.error('Al actualizar totales del asiento', err.error); this.authService.mostrarError('Error al actualizar totales del Asiento', err.error); }
         // });
      }
   }

   regresar() { this.router.navigate([this.padre]); }

   cerrar() { this.router.navigate(['/inicio']); }

   nuevo() {
      sessionStorage.setItem("datosToAddtransaci", JSON.stringify({
         idasiento: this.idasiento, totDebe: this.totDebe, totHaber: this.totHaber, tiptran: +this.tiptran, orden: 10 + (this._transacciones.length * 2)
      }
      ));
      switch (+this.tiptran) {
         case 0:
            this.router.navigate(['/add-transaccion']);
            break;
         case 1:
            this.router.navigate(['/add-trandetrami']);
            break;
         case 2:         case 3:         case 4:         case 5:         case 6:         case 7:
            this.router.navigate(['/add-benextran']);
            break;
         case 8:         case 9:         case 10:         case 11:         case 12:
            this.router.navigate(['/add-liquiacfp']);
            break;
         default:
         // 
      }
   }

   modificar(idtransaccion: number, tiptran: number) {
      // console.log('idtransaccion: ', idtransaccion)
      sessionStorage.setItem("datosToModiTransaccion", JSON.stringify({ idtransaccion: idtransaccion, idasiento: this.idasiento, totDebe: this.totDebe, totHaber: this.totHaber }));
      switch (tiptran) {
         case 0:
            this.router.navigate(['/modi-transaccion']);
            break;
         case 2:         case 3:         case 4:         case 5:         case 6:         case 7:
            // this.router.navigate(['/add-benextran']);
            break;
         case 8:         case 9:         case 10:         case 11:         case 12:
            // this.router.navigate(['/add-liquiacfp']);
            break;
         default:
         // 
      }

   }

   //Datos a eliminar
   eliminar(transa: Transacciones): void {
      this.ejecuService.countEjecucionPorPartida(transa.idtransaccion).subscribe({
         next: (registros:any) => {
            if (registros > 0) {
               Swal.fire({
                  icon: 'error',
                  title: `No puede eliminar la Cuenta: ${transa.codcue}`,
                  text: `Tiene registrado ${registros} pagos/cobros`,
                  confirmButtonText: '<i class="bi-check"></i> Continuar ',
                  customClass: {
                     popup: 'noeliminar',
                     title: 'robotobig',
                     confirmButton: 'btn btn-info',
                  },
               });
            } else {
               Swal.fire({
                  width: '500px',
                  title: 'Mensaje',
                  text: `Eliminar la Cuenta: ${transa.codcue} de este Asiento`,
                  icon: 'warning',
                  showCancelButton: true,
                  confirmButtonText: '<i class="fa fa-check"></i> Aceptar',
                  cancelButtonText: '<i class="fa fa-times"></i> Cancelar',
                  customClass: {
                     popup: 'eliminar',
                     title: 'robotobig',
                     confirmButton: 'btn btn-success',
                     cancelButton: 'btn btn-success'
                  },
               }).then((resultado) => {
                  if (resultado.isConfirmed) this.elimina(transa);
               });
            }
         },
         error: err => console.error('Al buscar si la Transacción ...: ', err.error),
      });
   }

   //Elimina
   elimina(transa: Transacciones) {
      this.tranService.deleteTransaccion(transa.idtransaccion).subscribe({
         next: () => {
            // this.buscar();
            let fecha: Date = new Date();
            let eliminado: Eliminados = new Eliminados();
            eliminado.idusuario = this.authService.idusuario!;
            eliminado.modulo = this.authService.moduActual;
            eliminado.fecha = fecha;
            eliminado.routerlink = 'transacciones';
            eliminado.tabla = 'TRANSACCIONES';
            eliminado.datos = `Cuenta: ${transa.codcue} ${transa.debcre === 1 ? 'Débito' : 'Crédito'} ${transa.valor} Comprobante: ${codcomprobante(transa.asiento.tipcom)}-${transa.asiento.compro}`;
            this.elimService.save(eliminado).subscribe({
               next: () => {
                  Swal.fire('Mensaje', 'La acción fue ejecutada.', 'success');
                  this.busca(true);
               },
               error: err => { console.error(err.error); this.authService.mostrarError('Error al eliminar', err.error); }
            });
         },
         error: err => { console.error(err.error); this.authService.mostrarError('Error al eliminar', err.error); }
      });
   }

   imprimir() {
      sessionStorage.setItem("idasientoToImpExp", this.idasiento.toString());
      this.router.navigate(['/imp-transaccion']);
   }

}

//Código Tipo de Comprobante
function codcomprobante(tipcom: number): string {
   if (tipcom == 1) return 'I-';
   if (tipcom == 2) return 'E-';
   if (tipcom == 3) return 'DC-';
   if (tipcom == 4) return 'DI-';
   if (tipcom == 5) return 'DE-';
   return '';
}

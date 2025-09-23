import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { AutorizaService } from '../../servicios/administracion/autoriza.service';
import { UsuariosService } from '../../servicios/administracion/usuarios.service';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-main-header',
  imports: [ReactiveFormsModule, CommonModule, RouterModule],
  templateUrl: './main-header.component.html',
  styleUrl: './main-header.component.css',
})
export class MainHeaderComponent implements OnInit {
  fondo1: number = 0;
  enabled: boolean[] = [];
  formDefinir!: FormGroup;
  tmpmodu: number = 0;

  readonly totMusica = 58;
  lastIndex: number | null = null;
  mensajeAudio: string = '';

  listaMusica = [
    { titulo: 'La conquista del paraiso', artista: 'Vangelis' },
    { titulo: 'Acapulco a los 2 de la tarde', artista: "The Topper's" },
    { titulo: 'Pandillas de los warriors', artista: 'Warriors' },
    { titulo: 'The full monty', artista: 'Anne Dudley' },
    { titulo: 'Angel de luz', artista: 'Aquitania' },
    { titulo: 'Para Elisa', artista: 'Beethoven' },
    { titulo: 'Tema de Braveheart', artista: 'James Horner' },
    { titulo: 'Zamba para ti', artista: 'Carlos Santana' },
    { titulo: 'Danza cenizas del paraiso', artista: 'Osvaldo Montes' },
    { titulo: 'Ameno', artista: 'Era' },
    { titulo: 'Czardasz Ashik Cygan', artista: 'Goran Bregovic' },
    { titulo: 'Quiero ser tu sombra', artista: 'Héctor Soto' },
    { titulo: 'Shut down', artista: 'Blackpink' },
    { titulo: 'El Amor', artista: 'José Luis Perales' },
    { titulo: 'Maria Elena', artista: 'Los Indios Tabajara' },
    { titulo: 'El hombre del brazo de oro', artista: 'Los Iracundos' },
    { titulo: 'Jinetes en el cielo', artista: 'Los Beatnicks' },
    { titulo: 'Rose', artista: 'James Horner' },
    { titulo: 'The baseball furies', artista: 'Barry De Vorzon' },
    { titulo: 'Zorba el Griego', artista: 'Nikos Kazantzakis' },
    { titulo: 'Cuelguenlos bien alto', artista: 'Enio Morricone' },
    { titulo: 'Un puñado de dólares', artista: 'Enio Morricone' },
    { titulo: 'Por unos dólares más', artista: 'Enio Morricone' },
    { titulo: 'El éxtacis del oro', artista: 'Hugo Montenegro' },
    { titulo: 'El bueno, el malo y el feo', artista: 'Enio Morricone' },
    { titulo: 'Por un puñado de dólares', artista: 'Hugo Montenegro' },
    { titulo: 'Titoli', artista: 'Hugo Montenegro' },
    { titulo: 'Apache', artista: 'The Shadows' },
    { titulo: 'Woo hoo hoo', artista: "5.6.7.8's" },
    { titulo: 'Carmina burana o fortuna', artista: 'Carl Orff' },
    { titulo: 'Ice ice baby', artista: 'Vanilla Ice' },
    { titulo: 'Bad guy', artista: 'Billie Eilish' },
    { titulo: 'Kakioki', artista: 'Meiko Kaji' },
    { titulo: 'One way ticket', artista: 'Eruption' },
    { titulo: 'El condor pasa', artista: 'Daniel Alomía Robles' },
    { titulo: 'Diego Verdaguer', artista: 'Diego Verdaguer' },
    { titulo: 'Venus', artista: 'Shoking Blue' },
    { titulo: 'A time for us', artista: 'Andy Williams' },
    { titulo: 'Hasta siempre comandante', artista: 'Carlos Puebla' },
    { titulo: 'Where do I begin', artista: 'Francis Lai' },
    { titulo: 'Shut down', artista: 'Blackpink' },
    { titulo: 'Lonely shepard', artista: '' },
    { titulo: 'Funkytown', artista: 'Lipps Inc' },
    { titulo: 'Kazachok', artista: 'Danza folclórica Eslava' },
    { titulo: 'Dschinghis Khan', artista: 'Dschinghis Khan' },
    { titulo: 'Fly Robin fly', artista: 'Silver Convention' },
    { titulo: 'The second waltz', artista: 'André Rieu' },
    { titulo: 'Born to be alive', artista: 'Patric Herbández' },
    { titulo: 'Knock on wood', artista: 'Amy Stewar' },
    { titulo: 'Last train to London', artista: 'Electric Light Orchesta' },
    { titulo: 'Happy Nation', artista: 'Ace of base' },
    { titulo: 'Rock and Roll is king', artista: 'Electric Light Orchesta' },
    { titulo: 'Agua fresca', artista: 'Afrosound' },
    { titulo: 'La danza de los mirlos', artista: 'Afrosound' },
    { titulo: 'Tiro al blanco', artista: 'Afrosound' },
    { titulo: 'Nice and slow', artista: 'Jesse Green' },
    { titulo: 'Ameno techno', artista: 'Era' },
    { titulo: 'La granja', artista: 'ZZ Top' },
  ];

  constructor(
    public fb: FormBuilder,
    public authService: AutorizaService,
    private usuService: UsuariosService
  ) {}

  ngOnInit(): void {
    //Fondo

    console.log(sessionStorage);
    let fondoActual = sessionStorage.getItem('fondoActual')?.toString();
    if (!fondoActual) {
      fondoActual = '1';
    }
    this.fondo1 = +fondoActual!;

    this.authService.valsession();

    this.authService.nombreModulo();

    if (this.authService.sessionlog) this.authService.enabModulos();
    else this.enabled = [false, false, false, false, false, false];

    this.formDefinir = this.fb.group({
      fdesde: '',
      fhasta: '',
      msgval: this.authService.msgval,
      numcancion: 1,
    });
  }

  fondo() {
    if (!this.fondo1) {
      this.fondo1 = 1;
    } else {
      this.fondo1 = this.fondo1 * -1;
    }
    sessionStorage.setItem('fondoActual', this.fondo1.toString());
    // this.footer.fondo(this.fondo1);
  }

  definir() {
    this.formDefinir!.controls['fdesde'].setValue(sessionStorage.getItem('fdesde'));
    this.formDefinir?.controls['fhasta'].setValue(sessionStorage.getItem('fhasta'));
    this.formDefinir?.patchValue({
      msgval: this.authService.msgval,
    });
  }

  guardarDefinir() {
    // console.log('Guarda: ', this.formDefinir.value.msgval)
    this.authService.msgval = this.formDefinir?.value.msgval;
    this.usuService.getByIdusuario(this.authService.idusuario!).subscribe({
      next: (resp: any) => {
        resp.fdesde = this.formDefinir!.value.fdesde;
        resp.fhasta = this.formDefinir!.value.fhasta;
        resp.msgval = this.formDefinir!.value.msgval;
        this.usuService.updateUsuario(this.authService.idusuario!, resp).subscribe({
          next: () => {
            // console.log('update ok!')
          },
          error: (err: any) => console.error(err.error),
        });
      },
      error: (err: any) => console.error(err.error),
    });
  }

  skipAudio(): void {
    let newIndex: number;
    do {
      newIndex = Math.floor(Math.random() * this.totMusica) + 1; // Generador aleatorio bien distribuido
    } while (newIndex === this.lastIndex);
    this.lastIndex = newIndex;
    this.formDefinir.controls['numcancion'].setValue(newIndex);
    this.playAudio(newIndex);
  }

  infoAudio(numCancion: number) {
    const cancion = this.listaMusica[numCancion - 1]; // El índice empieza en 1
    this.mensajeAudio = cancion ? `🎵 ${cancion.titulo} - ${cancion.artista}` : '';
  }

  playAudio(numCancion: number) {
    this.authService.playAudio(numCancion);
  }
}

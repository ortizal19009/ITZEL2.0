package com.itzel.modelo.administracion;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZonedDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "usuarios")
public class Usuarios {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idusuario;
    private String identificacion;
    private String codusu;
    private String nomusu;
    private LocalDate fdesde;
    private LocalDate fhasta;
    private String priusu;
    private String foto;
    private short modulo;
    private String alias;
    private boolean swmodulo1;
    private boolean swmodulo2;
    private boolean swmodulo3;
    private boolean swmodulo4;
    private boolean swmodulo5;
    private boolean swmodulo6;
    private Timestamp feccrea;
    private Timestamp fecmodi;
    private Long usumodi;
    private boolean msgval;
    private boolean swhabili;
    private boolean swmusica;

}
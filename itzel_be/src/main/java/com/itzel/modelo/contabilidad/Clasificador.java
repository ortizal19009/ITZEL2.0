package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name="clasificador")
public class Clasificador {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idclasificador;
    private String codpar;
    private short nivpar;
    private String grupar;
    private String nompar;
    private String despar;
    private String cueejepresu;
    private Integer presupuesto;
    private Integer ejecucion;
    private Integer devengado;
    private Integer reforma;
    @Column(name = "asigna_ini")
    private Integer asignaini;
    private String grupo;
    private Integer balancostos;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

}

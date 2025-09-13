package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "ejecucion")
public class Ejecucion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idejecucion;
    private String codpar;
    private LocalDate fecha;
    private short tipeje;
    private BigDecimal anticipo;
    private BigDecimal modifi;
    private BigDecimal prmiso;
    private BigDecimal totdeven;
    private BigDecimal devengado;
    private BigDecimal cobpagado;
    private String concepto;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;
    @JoinColumn(name = "idreforma")
    private Long reforma;
    @JoinColumn(name = "idtramite")
    private Long tramite;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpartixcer")
    private Partixcerti partixcerti;
    @JoinColumn(name = "idasiento")
    private Long asiento;
    @JoinColumn(name = "idtransaccion")
    private Long transaccion;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpresupuesto")
    private Presupuesto presupuesto;
    @JoinColumn(name = "idcompromiso")
    private Long compromisos;
}

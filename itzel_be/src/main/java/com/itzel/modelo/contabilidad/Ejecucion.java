package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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
    @JoinColumn(name = "idpartxcer")
    private Partixcerti partixcerti;
    @JoinColumn(name = "idasiento")
    private Long idasiento;
    @JoinColumn(name = "idtransaccion")
    private Long transaccion;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpresupuesto")
    private Presupuesto presupuesto;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcompromiso")
    private Compromisos compromiso;
}

package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "partixcerti")
public class Partixcerti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long idparxcer;
    private BigDecimal valor;
    private BigDecimal reintegro;
    private String descripcion;
    private BigDecimal totprmisos;
    private BigDecimal saldo;

    @ManyToOne(optional = true) // por defecto es true
    @JoinColumn(name = "idejecucion")
    private Ejecucion ejecucion;

    private Long idparxcer_;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcertificacion")
    private Certificaciones certificacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpresupuesto")
    private Presupuesto presupuesto;

}

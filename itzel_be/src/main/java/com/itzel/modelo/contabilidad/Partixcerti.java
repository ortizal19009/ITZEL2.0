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
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "partixcerti")
public class Partixcerti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idparxcer;
    private BigDecimal valor;
    private BigDecimal reintegro;
    private String descripcion;
    private BigDecimal totprmisos;
    private BigDecimal saldo;
    @JoinColumn(name = "idejecucion")
    private Short ejecucion;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcertificacion")
    private Certificaciones certificacion;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpresupuesto")
    private Presupuesto presupuesto;
    private Short idparxcer_;


}

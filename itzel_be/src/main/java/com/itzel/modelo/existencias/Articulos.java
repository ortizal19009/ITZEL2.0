package com.itzel.modelo.existencias;

import com.itzel.modelo.contabilidad.Cuentas;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "articulos")
public class Articulos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idarticulo;
    private String codigo;
    private String nombre;
    private String codcue;
    private String unidad;
    private BigDecimal inicial;
    private BigDecimal cosinicial;
    private BigDecimal actual;
    private BigDecimal cosactual;
    private BigDecimal costotal;
    private String descripcion;
    private float minimo;
    private float maximo;
    private boolean swinmediato;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcuenta")
    private Cuentas cuenta;

}

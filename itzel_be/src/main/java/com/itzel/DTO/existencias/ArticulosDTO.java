package com.itzel.DTO.existencias;

import com.itzel.modelo.contabilidad.Cuentas;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
public class ArticulosDTO {
    private short idarticulo;
    private String codigo;
    private String nombre;
    private String codcue;
    private String unidad;
    private BigDecimal inicial;
    private BigDecimal cosinicial;
    private Long actual;
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
    private Long cantidad;
}

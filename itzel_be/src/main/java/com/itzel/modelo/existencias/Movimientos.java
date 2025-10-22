package com.itzel.modelo.existencias;

import com.itzel.modelo.administracion.Documentos;
import com.itzel.modelo.contabilidad.Beneficiarios;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Movimientos {
    private Long idmovimiento;
    private Long tipmov;
    private Long numero;
    private Timestamp fecha;
    private Long numentrada;
    private BigDecimal total;
    private Long numart;
    private Long numdoc;
    private Timestamp fecdoc;
    private String compegre;
    private Boolean swaprobado;
    private String observaciones;
    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;
    private Destinos destino;
    private Beneficiarios beneficiario;
    private Documentos documento;
}

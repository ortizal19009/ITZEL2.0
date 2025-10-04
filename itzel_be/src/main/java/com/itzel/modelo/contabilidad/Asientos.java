package com.itzel.modelo.contabilidad;


import com.itzel.modelo.administracion.Documentos;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "asientos")
public class Asientos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idasiento;
    private Long numero;
    private LocalDate fecha;
    private byte tipasi;
    private byte tipcom;
    private long compro;
    private BigDecimal totdeb;
    private BigDecimal totcre;
    private String numdoc;
    private String concepto;

    private boolean swretencion;
    private boolean cerrado;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddocumento")
    private Documentos documento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario")
    private Beneficiarios beneficiario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idproyecto")
    private Proyectos proyecto;

}
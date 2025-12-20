package com.itzel.modelo.contabilidad;

import com.itzel.modelo.administracion.Documentos;
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
@Table(name = "compromisos")
public class Compromisos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idcompromiso;
    private short tipo;
    private long numero;
    private LocalDate fecha;
    private String numdoc;
    private LocalDate fecdoc;
    private BigDecimal total;
    private Boolean swmultiple;
    private Short estado;
    private String descripcion;
    private Integer comprobante;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario")
    private Beneficiarios beneficiario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddocumento")
    private Documentos documento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcontratacion")
    private Contratacion contratacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddepartamento")
    private Departamentos departamento;

}

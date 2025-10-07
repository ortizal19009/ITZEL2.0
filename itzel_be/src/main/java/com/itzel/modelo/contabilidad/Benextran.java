package com.itzel.modelo.contabilidad;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.itzel.modelo.administracion.Documentos;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "benextran")

public class Benextran {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idbenxtra;

    private String numdoc;
    private BigDecimal valor;
    private BigDecimal totpagcob;
    private BigDecimal pagocobro;
    private Long idpagocobro;
    private Long idpresupuesto;
    private String codparreci;
    private String codcuereci;
    private Long asierefe;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    // Tablas Foraneas
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario")
    private Beneficiarios beneficiario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idtransaccion")
    private Transacciones transaccion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddocumento")
    private Documentos documento;

}

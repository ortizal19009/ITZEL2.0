package com.itzel.modelo.contabilidad;

import com.itzel.modelo.administracion.Documentos;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "transacciones")
public class Transacciones {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idtransaccion;
    private short orden;
    private String codcue;
    private float valor;
    private byte debcre;
    private String numdoc;
    private String concepto;
    private byte tiptran;
    private String codpar;
    private boolean swconcili;
    private Byte mesconcili;
    private short totbene;
    private String codpartr;
    private String codcueiog;
    private Float debeiog;
    private Float haberiog;
    private Long asierefe;
    private Short idbanco;
    private Long tramite;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    // Tablas Foraneas
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idasiento")
    private Asientos asiento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcuenta")
    private Cuentas cuenta;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario")
    private Beneficiarios beneficiario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddocumento")
    private Documentos documento;

}

package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "presupuesto")
public class Presupuesto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idpresupuesto;
    private short tippar;
    private String codpar;
    private String codigo;
    private String nompar;
    private BigDecimal inicial;
    private BigDecimal totmod;
    private BigDecimal totcerti;
    private BigDecimal totmisos;
    private BigDecimal totdeven;
    private BigDecimal arrastre;
    private BigDecimal arrastreaa;

    private short usucrea;  //Con s minúscula porque es obligatorio (primitivo)
    private Timestamp feccrea;
    private Short usumodi;  //Con S mayúscula para que acepte nulos
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idproyecto")
    private Proyectos proyecto;   // Relación con Proyectos con el nombre de la tabla no como idproyecto

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idclasificador")
    private Clasificador clasificador;  // Relación con Clasificador con el nombre de la tabla no como idclasificador

    public Presupuesto() {
    }

    public Presupuesto(short idpresupuesto, short tippar, String codpar, String codigo, String nompar, BigDecimal inicial, BigDecimal totmod, BigDecimal totcerti, BigDecimal totmisos, BigDecimal totdeven, BigDecimal arrastre, BigDecimal arrastreaa, short usucrea, Timestamp feccrea, Short usumodi, Timestamp fecmodi, Proyectos proyecto, Clasificador clasificador) {
        this.idpresupuesto = idpresupuesto;
        this.tippar = tippar;
        this.codpar = codpar;
        this.codigo = codigo;
        this.nompar = nompar;
        this.inicial = inicial;
        this.totmod = totmod;
        this.totcerti = totcerti;
        this.totmisos = totmisos;
        this.totdeven = totdeven;
        this.arrastre = arrastre;
        this.arrastreaa = arrastreaa;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
        this.proyecto = proyecto;
        this.clasificador = clasificador;
    }

    public short getIdpresupuesto() {
        return idpresupuesto;
    }

    public void setIdpresupuesto(short idpresupuesto) {
        this.idpresupuesto = idpresupuesto;
    }

    public short getTippar() {
        return tippar;
    }

    public void setTippar(short tippar) {
        this.tippar = tippar;
    }

    public String getCodpar() {
        return codpar;
    }

    public void setCodpar(String codpar) {
        this.codpar = codpar;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNompar() {
        return nompar;
    }

    public void setNompar(String nompar) {
        this.nompar = nompar;
    }

    public BigDecimal getInicial() {
        return inicial;
    }

    public void setInicial(BigDecimal inicial) {
        this.inicial = inicial;
    }

    public BigDecimal getTotmod() {
        return totmod;
    }

    public void setTotmod(BigDecimal totmod) {
        this.totmod = totmod;
    }

    public BigDecimal getTotcerti() {
        return totcerti;
    }

    public void setTotcerti(BigDecimal totcerti) {
        this.totcerti = totcerti;
    }

    public BigDecimal getTotmisos() {
        return totmisos;
    }

    public void setTotmisos(BigDecimal totmisos) {
        this.totmisos = totmisos;
    }

    public BigDecimal getTotdeven() {
        return totdeven;
    }

    public void setTotdeven(BigDecimal totdeven) {
        this.totdeven = totdeven;
    }

    public BigDecimal getArrastre() {
        return arrastre;
    }

    public void setArrastre(BigDecimal arrastre) {
        this.arrastre = arrastre;
    }

    public BigDecimal getArrastreaa() {
        return arrastreaa;
    }

    public void setArrastreaa(BigDecimal arrastreaa) {
        this.arrastreaa = arrastreaa;
    }

    public short getUsucrea() {
        return usucrea;
    }

    public void setUsucrea(short usucrea) {
        this.usucrea = usucrea;
    }

    public Timestamp getFeccrea() {
        return feccrea;
    }

    public void setFeccrea(Timestamp feccrea) {
        this.feccrea = feccrea;
    }

    public Short getUsumodi() {
        return usumodi;
    }

    public void setUsumodi(Short usumodi) {
        this.usumodi = usumodi;
    }

    public Timestamp getFecmodi() {
        return fecmodi;
    }

    public void setFecmodi(Timestamp fecmodi) {
        this.fecmodi = fecmodi;
    }

    public Proyectos getProyecto() {
        return proyecto;
    }

    public void setProyecto(Proyectos proyecto) {
        this.proyecto = proyecto;
    }

    public Clasificador getClasificador() {
        return clasificador;
    }

    public void setClasificador(Clasificador clasificador) {
        this.clasificador = clasificador;
    }
}

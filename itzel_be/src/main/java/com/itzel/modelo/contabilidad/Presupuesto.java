package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
@Entity
@Table(name = "presupuesto")
public class Presupuesto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idpresupuesto;
    private Long tippar;
    private String codpar;
    private String codigo;
    private String nompar;
    private BigDecimal inicia;
    private BigDecimal totmod;
    private BigDecimal totcerti;
    private BigDecimal totmisos;
    private BigDecimal totdeven;
    private BigDecimal arrastre;
    private BigDecimal arrastreaa;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idproyecto")
    private Proyectos idproyecto;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idclasificador")
    private Clasificador idclasificador;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

    public Presupuesto(Long idpresupuesto, Long tippar, String codpar, String codigo, String nompar, BigDecimal inicia, BigDecimal totmod, BigDecimal totcerti, BigDecimal totmisos, BigDecimal totdeven, BigDecimal arrastre, BigDecimal arrastreaa, Proyectos idproyecto, Clasificador idclasificador, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi) {
        this.idpresupuesto = idpresupuesto;
        this.tippar = tippar;
        this.codpar = codpar;
        this.codigo = codigo;
        this.nompar = nompar;
        this.inicia = inicia;
        this.totmod = totmod;
        this.totcerti = totcerti;
        this.totmisos = totmisos;
        this.totdeven = totdeven;
        this.arrastre = arrastre;
        this.arrastreaa = arrastreaa;
        this.idproyecto = idproyecto;
        this.idclasificador = idclasificador;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Long getIdpresupuesto() {
        return idpresupuesto;
    }

    public void setIdpresupuesto(Long idpresupuesto) {
        this.idpresupuesto = idpresupuesto;
    }

    public Long getTippar() {
        return tippar;
    }

    public void setTippar(Long tippar) {
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

    public BigDecimal getInicia() {
        return inicia;
    }

    public void setInicia(BigDecimal inicia) {
        this.inicia = inicia;
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

    public Proyectos getIdproyecto() {
        return idproyecto;
    }

    public void setIdproyecto(Proyectos idproyecto) {
        this.idproyecto = idproyecto;
    }

    public Clasificador getIdclasificador() {
        return idclasificador;
    }

    public void setIdclasificador(Clasificador idclasificador) {
        this.idclasificador = idclasificador;
    }

    public Long getUsucrea() {
        return usucrea;
    }

    public void setUsucrea(Long usucrea) {
        this.usucrea = usucrea;
    }

    public LocalDate getFeccrea() {
        return feccrea;
    }

    public void setFeccrea(LocalDate feccrea) {
        this.feccrea = feccrea;
    }

    public Long getUsumodi() {
        return usumodi;
    }

    public void setUsumodi(Long usumodi) {
        this.usumodi = usumodi;
    }

    public LocalDate getFecmodi() {
        return fecmodi;
    }

    public void setFecmodi(LocalDate fecmodi) {
        this.fecmodi = fecmodi;
    }
}

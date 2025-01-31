package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
@Entity
@NoArgsConstructor
@Table(name="clasificador")
public class Clasificador {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idclasificador;
    private String codpar;
    private Long nivpar;
    private String grupar;
    private String nompar;
    private String despar;
    private String cueejepresu;
    private BigDecimal presupuesto;
    private BigDecimal ejecucion;
    private BigDecimal devengado;
    private BigDecimal reforma;
    private BigDecimal asigna_ini;
    private Long grupo;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;


    public Long getIdclasificador() {
        return idclasificador;
    }

    public void setIdclasificador(Long idclasificador) {
        this.idclasificador = idclasificador;
    }

    public String getCodpar() {
        return codpar;
    }

    public void setCodpar(String codpar) {
        this.codpar = codpar;
    }

    public Long getNivpar() {
        return nivpar;
    }

    public void setNivpar(Long nivpar) {
        this.nivpar = nivpar;
    }

    public String getGrupar() {
        return grupar;
    }

    public void setGrupar(String grupar) {
        this.grupar = grupar;
    }

    public String getNompar() {
        return nompar;
    }

    public void setNompar(String nompar) {
        this.nompar = nompar;
    }

    public String getDespar() {
        return despar;
    }

    public void setDespar(String despar) {
        this.despar = despar;
    }

    public String getCueejepresu() {
        return cueejepresu;
    }

    public void setCueejepresu(String cueejepresu) {
        this.cueejepresu = cueejepresu;
    }

    public BigDecimal getPresupuesto() {
        return presupuesto;
    }

    public void setPresupuesto(BigDecimal presupuesto) {
        this.presupuesto = presupuesto;
    }

    public BigDecimal getEjecucion() {
        return ejecucion;
    }

    public void setEjecucion(BigDecimal ejecucion) {
        this.ejecucion = ejecucion;
    }

    public BigDecimal getDevengado() {
        return devengado;
    }

    public void setDevengado(BigDecimal devengado) {
        this.devengado = devengado;
    }

    public BigDecimal getReforma() {
        return reforma;
    }

    public void setReforma(BigDecimal reforma) {
        this.reforma = reforma;
    }

    public BigDecimal getAsigna_ini() {
        return asigna_ini;
    }

    public void setAsigna_ini(BigDecimal asigna_ini) {
        this.asigna_ini = asigna_ini;
    }

    public Long getGrupo() {
        return grupo;
    }

    public void setGrupo(Long grupo) {
        this.grupo = grupo;
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

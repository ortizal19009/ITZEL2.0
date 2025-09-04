package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name="clasificador")
public class Clasificador {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idclasificador;
    private String codpar;
    private short nivpar;
    private String grupar;
    private String nompar;
    private String despar;
    private String cueejepresu;
    private Integer presupuesto;
    private Integer ejecucion;
    private Integer devengado;
    private Integer reforma;
    @Column(name = "asigna_ini")
    private Integer asignaini;
    private String grupo;
    private Integer balancostos;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    public Clasificador() {
    }

    public Clasificador(short idclasificador, String codpar, short nivpar, String grupar, String nompar, String despar, String cueejepresu, Integer presupuesto, Integer ejecucion, Integer devengado, Integer reforma, Integer asignaini, String grupo, Integer balancostos, short usucrea, Timestamp feccrea, Short usumodi, Timestamp fecmodi) {
        this.idclasificador = idclasificador;
        this.codpar = codpar;
        this.nivpar = nivpar;
        this.grupar = grupar;
        this.nompar = nompar;
        this.despar = despar;
        this.cueejepresu = cueejepresu;
        this.presupuesto = presupuesto;
        this.ejecucion = ejecucion;
        this.devengado = devengado;
        this.reforma = reforma;
        this.asignaini = asignaini;
        this.grupo = grupo;
        this.balancostos = balancostos;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public short getIdclasificador() {
        return idclasificador;
    }

    public void setIdclasificador(short idclasificador) {
        this.idclasificador = idclasificador;
    }

    public String getCodpar() {
        return codpar;
    }

    public void setCodpar(String codpar) {
        this.codpar = codpar;
    }

    public short getNivpar() {
        return nivpar;
    }

    public void setNivpar(short nivpar) {
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

    public Integer getPresupuesto() {
        return presupuesto;
    }

    public void setPresupuesto(Integer presupuesto) {
        this.presupuesto = presupuesto;
    }

    public Integer getEjecucion() {
        return ejecucion;
    }

    public void setEjecucion(Integer ejecucion) {
        this.ejecucion = ejecucion;
    }

    public Integer getDevengado() {
        return devengado;
    }

    public void setDevengado(Integer devengado) {
        this.devengado = devengado;
    }

    public Integer getReforma() {
        return reforma;
    }

    public void setReforma(Integer reforma) {
        this.reforma = reforma;
    }

    public Integer getAsignaini() {
        return asignaini;
    }

    public void setAsignaini(Integer asignaini) {
        this.asignaini = asignaini;
    }

    public String getGrupo() {
        return grupo;
    }

    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    public Integer getBalancostos() {
        return balancostos;
    }

    public void setBalancostos(Integer balancostos) {
        this.balancostos = balancostos;
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
}

package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name="cuentas")
public class Cuentas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idcuenta;
    private String codcue;
    private String nomcue;
    private Boolean movcue;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idnivel")
    private Niveles nivel;
    private String grucue;
    private String asodebe;
    private String asohaber;
    private Long tiptran;
    private Boolean sigef;
    private Long grubalances;
    private Long grufluefec;
    private Long resulcostos;
    private Long balancostos;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

    public Cuentas() {
    }

    public Long getIdcuenta() {
        return idcuenta;
    }

    public void setIdcuenta(Long idcuenta) {
        this.idcuenta = idcuenta;
    }

    public String getCodcue() {
        return codcue;
    }

    public void setCodcue(String codcue) {
        this.codcue = codcue;
    }

    public String getNomcue() {
        return nomcue;
    }

    public void setNomcue(String nomcue) {
        this.nomcue = nomcue;
    }

    public Boolean getMovcue() {
        return movcue;
    }

    public void setMovcue(Boolean movcue) {
        this.movcue = movcue;
    }

    public Niveles getNivel() {
        return nivel;
    }

    public void setNivel(Niveles nivel) {
        this.nivel = nivel;
    }

    public String getGrucue() {
        return grucue;
    }

    public void setGrucue(String grucue) {
        this.grucue = grucue;
    }

    public String getAsodebe() {
        return asodebe;
    }

    public void setAsodebe(String asodebe) {
        this.asodebe = asodebe;
    }

    public String getAsohaber() {
        return asohaber;
    }

    public void setAsohaber(String asohaber) {
        this.asohaber = asohaber;
    }

    public Long getTiptran() {
        return tiptran;
    }

    public void setTiptran(Long tiptran) {
        this.tiptran = tiptran;
    }

    public Boolean getSigef() {
        return sigef;
    }

    public void setSigef(Boolean sigef) {
        this.sigef = sigef;
    }

    public Long getGrubalances() {
        return grubalances;
    }

    public void setGrubalances(Long grubalances) {
        this.grubalances = grubalances;
    }

    public Long getGrufluefec() {
        return grufluefec;
    }

    public void setGrufluefec(Long grufluefec) {
        this.grufluefec = grufluefec;
    }

    public Long getResulcostos() {
        return resulcostos;
    }

    public void setResulcostos(Long resulcostos) {
        this.resulcostos = resulcostos;
    }

    public Long getBalancostos() {
        return balancostos;
    }

    public void setBalancostos(Long balancostos) {
        this.balancostos = balancostos;
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

    public Cuentas(Long idcuenta, String codcue, String nomcue, Boolean movcue, Niveles nivel, String grucue, String asodebe, String asohaber, Long tiptran, Boolean sigef, Long grubalances, Long grufluefec, Long resulcostos, Long balancostos, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi) {
        this.idcuenta = idcuenta;
        this.codcue = codcue;
        this.nomcue = nomcue;
        this.movcue = movcue;
        this.nivel = nivel;
        this.grucue = grucue;
        this.asodebe = asodebe;
        this.asohaber = asohaber;
        this.tiptran = tiptran;
        this.sigef = sigef;
        this.grubalances = grubalances;
        this.grufluefec = grufluefec;
        this.resulcostos = resulcostos;
        this.balancostos = balancostos;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }
}

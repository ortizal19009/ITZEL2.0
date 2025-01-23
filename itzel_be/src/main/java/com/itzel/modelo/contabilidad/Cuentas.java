package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.commons.io.filefilter.SymbolicLinkFileFilter;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@NoArgsConstructor
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
    private Niveles idnivel;
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

    public Niveles getIdnivel() {
        return idnivel;
    }

    public void setIdnivel(Niveles idnivel) {
        this.idnivel = idnivel;
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

    public void setResulcostos(Long resultcostos) {
        this.resulcostos = resultcostos;
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
}

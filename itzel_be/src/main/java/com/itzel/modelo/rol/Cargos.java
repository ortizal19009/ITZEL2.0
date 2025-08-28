package com.itzel.modelo.rol;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "cargos")
public class Cargos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idcargo;
    private String nomcargo;
    private BigDecimal valor;
    private String descargo;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    public Cargos(Short idcargo, String nomcargo, BigDecimal valor, String descargo, short usucrea, Timestamp feccrea, Short usumodi, Timestamp fecmodi) {
        this.idcargo = idcargo;
        this.nomcargo = nomcargo;
        this.valor = valor;
        this.descargo = descargo;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Cargos() {

    }

    public Short getIdcargo() {
        return idcargo;
    }

    public void setIdcargo(Short idcargo) {
        this.idcargo = idcargo;
    }

    public String getNomcargo() {
        return nomcargo;
    }

    public void setNomcargo(String nomcargo) {
        this.nomcargo = nomcargo;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public String getDescargo() {
        return descargo;
    }

    public void setDescargo(String descargo) {
        this.descargo = descargo;
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


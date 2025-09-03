package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name = "tabla4")
public class Tabla4 {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idtabla4;
    private String tipocomprobante;
    private String nomcomprobante;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

    public Tabla4() {
    }

    public Tabla4(Long idtabla4, String tipocomprobante, String nomcomprobante, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi) {
        this.idtabla4 = idtabla4;
        this.tipocomprobante = tipocomprobante;
        this.nomcomprobante = nomcomprobante;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Long getIdtabla4() {
        return idtabla4;
    }

    public void setIdtabla4(Long idtabla4) {
        this.idtabla4 = idtabla4;
    }

    public String getTipocomprobante() {
        return tipocomprobante;
    }

    public void setTipocomprobante(String tipocomprobante) {
        this.tipocomprobante = tipocomprobante;
    }

    public String getNomcomprobante() {
        return nomcomprobante;
    }

    public void setNomcomprobante(String nomcomprobante) {
        this.nomcomprobante = nomcomprobante;
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

package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@Data
@Entity
@Table(name = "proyectos")
public class Proyectos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idproyecto;
    private String codigo;
    private String nombre;
    private Boolean movimiento;

    @ManyToOne
    @JoinColumn(name = "idestructura")
    private Estructura estructura;

    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;

    public Proyectos() {
    }

    public Proyectos(Long idproyecto, String codigo, String nombre, Boolean movimiento, Estructura estructura, Long usucrea, Timestamp feccrea, Long usumodi, Timestamp fecmodi) {
        this.idproyecto = idproyecto;
        this.codigo = codigo;
        this.nombre = nombre;
        this.movimiento = movimiento;
        this.estructura = estructura;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Long getIdproyecto() {
        return idproyecto;
    }

    public void setIdproyecto(Long idproyecto) {
        this.idproyecto = idproyecto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Boolean getMovimiento() {
        return movimiento;
    }

    public void setMovimiento(Boolean movimiento) {
        this.movimiento = movimiento;
    }

    public Estructura getEstructura() {
        return estructura;
    }

    public void setEstructura(Estructura estructura) {
        this.estructura = estructura;
    }

    public Long getUsucrea() {
        return usucrea;
    }

    public void setUsucrea(Long usucrea) {
        this.usucrea = usucrea;
    }

    public Timestamp getFeccrea() {
        return feccrea;
    }

    public void setFeccrea(Timestamp feccrea) {
        this.feccrea = feccrea;
    }

    public Long getUsumodi() {
        return usumodi;
    }

    public void setUsumodi(Long usumodi) {
        this.usumodi = usumodi;
    }

    public Timestamp getFecmodi() {
        return fecmodi;
    }

    public void setFecmodi(Timestamp fecmodi) {
        this.fecmodi = fecmodi;
    }
}

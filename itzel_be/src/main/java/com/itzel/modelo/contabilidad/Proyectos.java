package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "proyectos")
public class Proyectos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idproyecto;
    private String codigo;
    private String nombre;
    private Boolean movimiento;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idestructura")
    private Estructura idestructura;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

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

    public Estructura getIdestructura() {
        return idestructura;
    }

    public void setIdestructura(Estructura idestructura) {
        this.idestructura = idestructura;
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

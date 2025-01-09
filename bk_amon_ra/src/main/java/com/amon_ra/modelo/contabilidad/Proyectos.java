package com.amon_ra.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

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
    @JoinColumn(name = "idestructura_estructura")
    private Estructura idestructura_estructura;

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

    public Estructura getIdestructura_estructura() {
        return idestructura_estructura;
    }

    public void setIdestructura_estructura(Estructura idestructura_estructura) {
        this.idestructura_estructura = idestructura_estructura;
    }
}

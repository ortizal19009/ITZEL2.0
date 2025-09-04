package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Setter
@Getter
@Table(name = "estructura")
public class Estructura {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idestructura;
    private Long nivel;
    private String nombre;
    private Long longitud;

    public Estructura() {
    }

    public Estructura(Long idestructura, Long nivel, String nombre, Long longitud) {
        this.idestructura = idestructura;
        this.nivel = nivel;
        this.nombre = nombre;
        this.longitud = longitud;
    }

    public Long getIdestructura() {
        return idestructura;
    }

    public void setIdestructura(Long idestructura) {
        this.idestructura = idestructura;
    }

    public Long getNivel() {
        return nivel;
    }

    public void setNivel(Long nivel) {
        this.nivel = nivel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Long getLongitud() {
        return longitud;
    }

    public void setLongitud(Long longitud) {
        this.longitud = longitud;
    }
}


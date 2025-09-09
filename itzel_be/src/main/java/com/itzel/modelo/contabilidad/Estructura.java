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
    private Short idestructura;
    private Long nivel;
    private String nombre;
    private Long longitud;
    private Long sumlongitud;

    public Estructura() {
    }

    public Estructura(Short idestructura, Long nivel, String nombre, Long longitud, Long sumlongitud) {
        this.idestructura = idestructura;
        this.nivel = nivel;
        this.nombre = nombre;
        this.longitud = longitud;
        this.sumlongitud = sumlongitud;
    }

    public Short getIdestructura() {
        return idestructura;
    }

    public void setIdestructura(Short idestructura) {
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

    public Long getSumlongitud() {
        return sumlongitud;
    }

    public void setSumlongitud(Long sumlongitud) {
        this.sumlongitud = sumlongitud;
    }
}


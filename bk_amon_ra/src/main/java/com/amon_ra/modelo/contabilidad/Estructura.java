package com.amon_ra.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "estructura")
public class Estructura {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idestructura;
    private Long nivel;
    private String nombre;
    private Long longitud;

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

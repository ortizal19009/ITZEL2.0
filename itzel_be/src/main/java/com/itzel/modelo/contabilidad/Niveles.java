package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@Table(name = "niveles")
public class Niveles {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idnivel;
    private String nomniv;
    private Long longniv;

    public Long getIdnivel() {
        return idnivel;
    }

    public void setIdnivel(Long idnivel) {
        this.idnivel = idnivel;
    }

    public String getNomniv() {
        return nomniv;
    }

    public void setNomniv(String nomniv) {
        this.nomniv = nomniv;
    }

    public Long getLongniv() {
        return longniv;
    }

    public void setLongniv(Long longniv) {
        this.longniv = longniv;
    }

    public Niveles(Long idnivel, String nomniv, Long longniv) {
        this.idnivel = idnivel;
        this.nomniv = nomniv;
        this.longniv = longniv;
    }

    public Niveles() {
    }
}

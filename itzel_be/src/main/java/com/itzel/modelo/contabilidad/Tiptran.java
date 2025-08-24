package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@Table(name = "tiptran")
public class Tiptran {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long numero;
    private String nombre;

    public Long getNumero() {
        return numero;
    }

    public void setNumero(Long numero) {
        this.numero = numero;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Tiptran(Long numero, String nombre) {
        this.numero = numero;
        this.nombre = nombre;
    }

    public Tiptran() {
    }
}

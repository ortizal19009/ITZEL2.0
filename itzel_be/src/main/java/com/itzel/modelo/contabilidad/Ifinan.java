package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;

@Entity
@Table(name = "ifinan")
public class Ifinan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idifinan;
    private String codifinan;
    private String nomifinan;
    private String foto;

    public Ifinan() {
        super();
    }

    public Long getIdifinan() {
        return idifinan;
    }

    public void setIdifinan(Long idifinan) {
        this.idifinan = idifinan;
    }

    public String getCodifinan() {
        return codifinan;
    }

    public void setCodifinan(String codifinan) {
        this.codifinan = codifinan;
    }

    public String getNomifinan() {
        return nomifinan;
    }

    public void setNomifinan(String nomifinan) {
        this.nomifinan = nomifinan;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
}

package com.itzel.jasperReports.modelo;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@RequiredArgsConstructor
@Entity
@Table(name = "repoxopcion")
@Getter
@Setter
public class Repoxopcion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idrepoxopcion;

    private String codigo;
    private String opcion;
    private String nombre;
    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    @PrePersist
    protected void onCreate() {
        feccrea = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        fecmodi = new Timestamp(System.currentTimeMillis());
    }

    // Constructor adicional para inicializar solo idrepoxopcion
    public Repoxopcion(Short idrepoxopcion) {
        this.idrepoxopcion = idrepoxopcion;
    }

}


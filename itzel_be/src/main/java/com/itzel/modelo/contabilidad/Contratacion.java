package com.itzel.modelo.contabilidad;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "contratacion")

public class Contratacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idcontratacion;
    private String nombre;
    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

}

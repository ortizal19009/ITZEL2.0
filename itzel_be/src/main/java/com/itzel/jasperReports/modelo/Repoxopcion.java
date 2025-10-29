package com.itzel.jasperReports.modelo;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "repoxopcion")
public class Repoxopcion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idrepoxopcion;
    private String codigo;
    private String opcion;
    private String nombre;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;


}

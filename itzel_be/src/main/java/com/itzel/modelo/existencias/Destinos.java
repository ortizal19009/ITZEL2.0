package com.itzel.modelo.existencias;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "destinos")
public class Destinos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short iddestino;
    private String nomdestino;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

}

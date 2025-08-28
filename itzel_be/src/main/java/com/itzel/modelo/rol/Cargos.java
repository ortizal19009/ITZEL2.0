package com.itzel.modelo.contabilidad;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "cargos")
public class Cargos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idcargo;
    private String nomcargo;
    private BigDecimal valor;
    private String descargo;

    private short usucrea;
    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

}


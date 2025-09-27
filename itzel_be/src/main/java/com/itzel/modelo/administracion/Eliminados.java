package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "eliminados")
public class Eliminados {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ideliminado;

    private short idusuario;
    private short modulo;
    private Timestamp fecha;
    private String routerlink;
    private String tabla;
    private String datos;


}

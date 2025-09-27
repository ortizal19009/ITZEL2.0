package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "proyectos")
public class Proyectos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idproyecto;
    private String codigo;
    private String nombre;
    private Boolean movimiento;

    @ManyToOne
    @JoinColumn(name = "idestructura")
    private Estructura estructura;

    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;


}

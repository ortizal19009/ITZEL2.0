package com.amon_ra.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "estrfunc")
public class Estrfunc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idestrfunc;
    private String codigo;
    private String nombre;
    private Boolean movimiento;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idestructura_estructura")
    private Estructura idestructura_estructura;

}

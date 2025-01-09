package com.amon_ra.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "proyectos")
public class Proyectos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idproyecto;
    private String codigo;
    private String nombre;
    private Boolean movimiento;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idestructura_estructura")
    private Estructura idestructura_estructura;

}

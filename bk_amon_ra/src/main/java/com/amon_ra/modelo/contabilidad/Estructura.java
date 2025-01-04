package com.amon_ra.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "estructura")
public class Estructura {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idestructura;
    private Long nivel;
    private String nombre;
    private Long longitud;

}

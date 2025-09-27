package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "niveles")
public class Niveles {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idnivel;
    private String nomniv;
    private Long longniv;

}

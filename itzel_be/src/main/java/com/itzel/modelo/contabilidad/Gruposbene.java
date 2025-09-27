package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "gruposbene")
public class Gruposbene {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idgrupo;
    private String codgru;
    private String nomgru;
    private Long modulo1;
    private Long modulo2;
    private Long modulo3;
    private Long modulo4;
    private Long modulo5;
    private Long modulo6;

}

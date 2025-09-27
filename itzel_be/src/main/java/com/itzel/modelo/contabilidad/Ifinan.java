package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "ifinan")
public class Ifinan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idifinan;
    private String codifinan;
    private String nomifinan;
    private String foto;
}

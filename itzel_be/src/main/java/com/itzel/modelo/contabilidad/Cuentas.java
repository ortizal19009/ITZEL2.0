package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name="cuentas")
public class Cuentas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idcuenta;
    private String codcue;
    private String nomcue;
    private Boolean movcue;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idnivel")
    private Niveles nivel;
    private String grucue;
    private String asodebe;
    private String asohaber;
    private Long tiptran;
    private Boolean sigef;
    private Long grubalances;
    private Long grufluefec;
    private Long resulcostos;
    private Long balancostos;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

}

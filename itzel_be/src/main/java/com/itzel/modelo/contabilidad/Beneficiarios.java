package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "beneficiarios")
public class Beneficiarios {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idbeneficiario;
    private String codben;
    private String nomben;
    private String tpidben;
    private String rucben;
    private String ciben;
    private String tlfben;
    private String dirben;
    private String mailben;
    private Long tpcueben;
    private String cuebanben;
    private String foto;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idgrupo")
    private Gruposbene grupo;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idifinan")
    private Ifinan ifinan;
    private Long swconsufin;
    private Integer modulo;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

}

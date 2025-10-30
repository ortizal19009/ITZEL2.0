package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;
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
    private String rucben;
    private String ciben;
    private String tlfben;
    private String dirben;
    private String emailben;
    private Long tpcuebank;
    private String cuebank;
    private boolean swconsufin;
    private String foto;
    private Long idtpidentifica;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idgrupo")
    private Gruposbene grupo;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idifinan")
    private Ifinan ifinan;
    private boolean swmodulo1;
    private boolean swmodulo2;
    private boolean swmodulo3;
    private boolean swmodulo4;
    private boolean swmodulo5;
    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;
}

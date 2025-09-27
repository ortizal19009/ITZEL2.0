package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "presupuesto")
public class Presupuesto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idpresupuesto;
    private short tippar;
    private String codpar;
    private String codigo;
    private String nompar;
    private BigDecimal inicial;
    private BigDecimal totmod;
    private BigDecimal totcerti;
    private BigDecimal totmisos;
    private BigDecimal totdeven;
    private BigDecimal arrastre;
    private BigDecimal arrastreaa;

    private short usucrea;  //Con s minúscula porque es obligatorio (primitivo)
    private Timestamp feccrea;
    private Short usumodi;  //Con S mayúscula para que acepte nulos
    private Timestamp fecmodi;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idproyecto")
    private Proyectos proyecto;   // Relación con Proyectos con el nombre de la tabla no como idproyecto

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idclasificador")
    private Clasificador clasificador;  // Relación con Clasificador con el nombre de la tabla no como idclasificador


}

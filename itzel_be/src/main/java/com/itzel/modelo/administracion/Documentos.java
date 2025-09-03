package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name = "documentos")
public class Documentos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long iddocumento;
    private String nomdoc;
    private int tipdoc;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idtabla4")
    private Tabla4 tabla4;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;


}

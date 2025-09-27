package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;


import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "definir")
public class Definir {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long iddefinir;
    private String empresa;
    private String razonsocial;
    private String nombrecomercial;
    private String ruc;
    private String direccion;
    private Byte tipoambiente;
    private float iva;
    private LocalDate fechap;
    private String f_i;
    private String f_g;
    private Short longparing;
    private Short longpargas;


}

package com.itzel.modelo.contabilidad;

import com.itzel.modelo.administracion.Documentos;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "certificaciones")
public class Certificaciones {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idcertificacion;
    private int tipo;
    private int numero;
    private LocalDate fecha;
    private BigDecimal valor;
    private String descripcion;
    private String numdoc;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn (name = "idbeneficiario")
    private Beneficiarios beneficiario;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiariores")
    private Beneficiarios beneficiariores;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn (name = "iddocumento")
    private Documentos documento;


}

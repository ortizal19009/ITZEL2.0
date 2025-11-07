package com.itzel.modelo.existencias;

import com.itzel.modelo.administracion.Documentos;
import com.itzel.modelo.contabilidad.Beneficiarios;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "movimientos")
public class Movimientos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idmovimiento;
    private Short tipmov;
    private Long numero;
    private Timestamp fecha;
    private Long numentrada;
    private BigDecimal total;
    private Long numart;
    private String numdoc;
    private Timestamp fecdoc;
    private String compegre;
    private Boolean swaprobado;
    private String observaciones;
    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddestino")
    private Destinos destino;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario", nullable = false)
    private Beneficiarios beneficiario;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iddocumento")
    private Documentos documento;
}

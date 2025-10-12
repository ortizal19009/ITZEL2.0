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
@Table(name = "pedidos")
public class Pedidos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idpedido;
    private int numero;
    private Timestamp fecha;
    private BigDecimal total;
    private String descripcion;
    private String numdoc;
    @ManyToOne
    @JoinColumn(name = "iddocumento")
    private Documentos documento;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiario")
    private Beneficiarios beneficiario;
    @ManyToOne
    @JoinColumn(name = "iddestino")
    private Destinos destino;

}
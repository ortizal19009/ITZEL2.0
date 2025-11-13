package com.itzel.modelo.existencias;

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
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "artimovi")
public class Artimovi {
    @Id
    @GeneratedValue(strategy =GenerationType.IDENTITY)
    private Short idartimovi;
    private short tipmov;
    private float cantidad;
    private BigDecimal total;
    private BigDecimal cosprom;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="idmovimiento")
    private Movimientos movimiento;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idarticulo")
    private Articulos articulo;
}

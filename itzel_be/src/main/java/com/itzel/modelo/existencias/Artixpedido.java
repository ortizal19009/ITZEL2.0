package com.itzel.modelo.existencias;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name="artixpedido")
public class Artixpedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short idartixpedido;
    private Long cantidad;
    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idarticulo")
    private Articulos articulo;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idpedido")
    private Pedidos pedido;
}

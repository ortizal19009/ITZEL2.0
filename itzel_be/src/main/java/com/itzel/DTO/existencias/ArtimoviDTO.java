package com.itzel.DTO.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Movimientos;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Data
public class ArtimoviDTO {
    private short tipmov;
    private float cantidad;
    private BigDecimal total;
    private BigDecimal cosprom;
    private Short usucrea;
    private Timestamp feccrea;
    private short usumodi;
    private Timestamp fecmodi;

    private Movimientos movimiento;

    // Ahora acepta varios artículos
    private List<Articulos> articulos;
}


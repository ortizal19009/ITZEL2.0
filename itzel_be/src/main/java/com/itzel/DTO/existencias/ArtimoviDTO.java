package com.itzel.DTO.existencias;
import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Movimientos;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Data
public class ArtimoviDTO {
    @NotNull
    private Short tipmov;

    @NotNull @Positive
    private Float cantidad;

    @NotNull
    private BigDecimal total;

    @NotNull
    private BigDecimal cosprom;

    @NotNull
    private Short usucrea;

    private Timestamp feccrea;

    @NotNull
    private Short usumodi;

    private Timestamp fecmodi;

    @NotNull @Valid
    private Movimientos movimiento;

    @NotEmpty
    private List<@Valid Articulos> articulos;
}


package com.itzel.DTO.existencias;

import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Data
public class ArtimoviRequestDTO {

    @NotNull(message = "tipmov es obligatorio")
    private Short tipmov;

    @NotNull(message = "cantidad es obligatoria")
    @Positive(message = "cantidad debe ser mayor a 0")
    private Float cantidad;

    @NotNull(message = "total es obligatorio")
    @DecimalMin(value = "0.00", inclusive = false, message = "total debe ser mayor a 0")
    private BigDecimal total;

    @NotNull(message = "cosprom es obligatorio")
    @DecimalMin(value = "0.00", inclusive = true, message = "cosprom no puede ser negativo")
    private BigDecimal cosprom;

    @NotNull(message = "usucrea es obligatorio")
    @Positive(message = "usucrea debe ser mayor a 0")
    private Short usucrea;

    private Timestamp feccrea;

    @NotNull(message = "usumodi es obligatorio")
    @Positive(message = "usumodi debe ser mayor a 0")
    private Short usumodi;

    private Timestamp fecmodi;

    @NotNull(message = "movimiento es obligatorio")
    @Valid
    private MovimientoIdDTO movimiento;

    @NotEmpty(message = "Debe enviar al menos un artículo")
    private List<@Valid ArticuloCreateDTO> articulos;
}

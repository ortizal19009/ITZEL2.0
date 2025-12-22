package com.itzel.DTO.existencias;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class MovimientoIdDTO {
    @NotNull(message = "idmovimiento es obligatorio")
    private Short idmovimiento;
}

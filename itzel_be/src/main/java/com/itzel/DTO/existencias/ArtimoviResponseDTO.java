package com.itzel.DTO.existencias;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class ArtimoviResponseDTO {
    private Short idmovimiento;
    private List<Short> idsArticulos;
    private String mensaje;
}

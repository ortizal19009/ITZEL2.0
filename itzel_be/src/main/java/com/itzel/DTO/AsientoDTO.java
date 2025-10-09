package com.itzel.DTO;

import java.math.BigDecimal;

public record AsientoDTO(
        short idasiento,
        BigDecimal totdeb,
        BigDecimal totcre
) {
}

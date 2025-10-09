package com.itzel.DTO;

import java.math.BigDecimal;

public record TransaccionDTO(
        Long id,
        short asientoId,
        Long cuentaId,
        Long beneficiarioId,
        BigDecimal valor,
        byte debcre
) {}
package com.itzel.DTO;

public record SaveTxResponse(
        TransaccionDTO transaccion,
        AsientoDTO asiento,
        boolean asientoActualizado
) {}
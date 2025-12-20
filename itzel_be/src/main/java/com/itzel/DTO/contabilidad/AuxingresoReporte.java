package com.itzel.DTO.contabilidad;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuxingresoReporte {
    private String fecha;
    private String asiento;
    private BigDecimal modifi;
    private BigDecimal codificado;
    private BigDecimal devengado;
    private BigDecimal cobrado;
    private BigDecimal saldo_devengado;
    private BigDecimal saldo_cobrado;
    private String concepto;

}

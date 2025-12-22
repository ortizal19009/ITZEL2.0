package com.itzel.DTO.existencias;

import com.itzel.modelo.contabilidad.Cuentas;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
public class ArticuloCreateDTO {

    @NotBlank(message = "codigo es obligatorio")
    @Size(max = 50, message = "codigo máximo 50")
    private String codigo;

    @NotBlank(message = "nombre es obligatorio")
    @Size(max = 200, message = "nombre máximo 200")
    private String nombre;

    private String codcue;
    private String unidad;

    private BigDecimal inicial;
    private BigDecimal cosinicial;
    private Long actual;
    private BigDecimal cosactual;
    private BigDecimal costotal;
    private String descripcion;

    @DecimalMin(value = "0.00", message = "minimo no puede ser negativo")
    private Float minimo;

    @DecimalMin(value = "0.00", message = "maximo no puede ser negativo")
    private Float maximo;

    private Boolean swinmediato;

    @NotNull(message = "usucrea es obligatorio")
    @Positive(message = "usucrea debe ser mayor a 0")
    private Short usucrea;

    private Timestamp feccrea;
    private Short usumodi;
    private Timestamp fecmodi;

    private Cuentas cuenta; // opcional fallback si aún mandas objeto
}

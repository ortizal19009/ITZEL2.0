package com.itzel.DTO.existencias;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
public class MovimientoRefDTO {

    // Si viene, se usa existente
    private Short idmovimiento;

    // Si NO viene idmovimiento, se crea nuevo (pon obligatorios los que sí o sí necesitas)
    private Short tipmov;
    private Long numero;
    private Timestamp fecha;
    private Long numentrada;

    private BigDecimal total;
    private Long numart;
    private String numdoc;
    private Timestamp fecdoc;
    private String compegre;
    private Boolean swaprobado;
    private String observaciones;

    private Long usucrea;
    private Timestamp feccrea;
    private Long usumodi;
    private Timestamp fecmodi;

    // relaciones por ID (no mandar objetos)
    private Long iddestino;

    @NotNull(message = "idbeneficiario es obligatorio")
    private Long idbeneficiario;

    private Long iddocumento;
}

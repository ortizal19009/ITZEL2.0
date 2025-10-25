package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Movimientos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MovimientosR extends JpaRepository<Movimientos, Short> {
    //Buscar los movimientos por tipo de movimiento (ingreso ó salida)
    List<Movimientos> findByTipmov(Short tipmov);
    //Encontrar el último numero de los movimientos para generar el secuencial diferenciando ingresos y salidas
    @Query("SELECT MAX(m.numero) FROM Movimientos m WHERE m.tipmov = :tipmov")
    Integer findUltimoNumero(@Param("tipmov") short tipmov);
    //Verificar si existe el numero de movimiento por tipo y numero
    @Query("SELECT CASE WHEN COUNT(m) > 0 THEN true ELSE false END FROM Movimientos m WHERE m.tipmov = :tipmov AND m.numero = :numero")
    boolean existsByTipoAndNumero(@Param("tipmov") short tipmov, @Param("numero") Long numero);
}

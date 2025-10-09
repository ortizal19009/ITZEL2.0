package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Transacciones;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TransaccionesR extends JpaRepository<Transacciones, Long> {

    // Transacciones por Asiento
    List<Transacciones> findByAsiento_IdasientoOrderByOrden(Short idasiento);

    // Si necesitas el listado (no es obligatorio con el agregado de abajo):
    List<Transacciones> findByAsiento_IdasientoOrderByOrden(short idasiento);

    // Agregados (más eficiente que traer todo a memoria)
    @Query("""
    SELECT 
        COALESCE(SUM(CASE WHEN t.debcre = 1 THEN t.valor ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN t.debcre = 2 THEN t.valor ELSE 0 END), 0)
    FROM Transacciones t
    WHERE t.asiento.idasiento = :idasiento
""")
    Object[] sumDebCreByAsiento(@Param("idasiento") short idasiento);

    @Query("""
    SELECT COALESCE(SUM(t.valor), 0)
    FROM Transacciones t
    WHERE t.asiento.idasiento = :idasiento AND t.debcre = 1
""")
    Number sumDebe(@Param("idasiento") short idasiento);

    @Query("""
    SELECT COALESCE(SUM(t.valor), 0)
    FROM Transacciones t
    WHERE t.asiento.idasiento = :idasiento AND t.debcre = 2
""")
    Number sumHaber(@Param("idasiento") short idasiento);



}

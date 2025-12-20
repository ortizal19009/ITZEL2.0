package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Ejecucion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface EjecucionR extends JpaRepository<Ejecucion, Long> {

    // Conteo de las Partixcerti de una Ejecucion (compromismos de una partixcerti)
    short countByPartixcerti_Idparxcer(Long idparxcer);

    // Partixcerti de una Ejecucion
    List<Ejecucion> findByPartixcerti_Idparxcer(Long idparxcer);

    // Conteo por Idpresupuesto
    short countByPresupuesto_Idpresupuesto(Short idpresupuesto);

    // Suma Ejecucion.prmiso para actualizar en compromisos
    @Query("SELECT COALESCE(SUM(e.prmiso), 0) FROM Ejecucion e WHERE e.compromiso.idcompromiso = :idcompromiso")
    BigDecimal sumarPrmisoPorIdcompromiso(@Param("idcompromiso") Short idcompromiso);

    // Partidas de un Compromiso
    List<Ejecucion> findByCompromiso_IdcompromisoOrderByPresupuestoProyectoCodigoAscPresupuestoCodparAsc(
            Short idcompromiso);

    // Ejecución de una Partida (auxiliar presupuestario por idpresupuesto)
    List<Ejecucion> findByPresupuesto_IdpresupuestoAndFechaBetweenOrderByFechaAscIdejecucionAsc(Short idpresupuesto,
                                                                                                LocalDate desde, LocalDate hasta);

    // Suma ejecucion.prmiso para actualizar presupuesto.totmisos
    @Query("SELECT COALESCE(SUM(e.prmiso), 0) FROM Ejecucion e WHERE e.presupuesto.idpresupuesto = :idpresupuesto")
    BigDecimal sumaPrmisoPorPartida(@Param("idpresupuesto") Short idpresupuesto);

    // Suma ejecucion.prmiso para actualizar partixcerti.totprmisos
    @Query("SELECT COALESCE(SUM(e.prmiso), 0) FROM Ejecucion e WHERE e.partixcerti.idparxcer = :idparxcer")
    BigDecimal sumaPrmisoPorIdparxcer(@Param("idparxcer") Long idparxcer);

    // Suma ejecucion.devengado para actualizar presupuesto.totdeven
    @Query("SELECT COALESCE(SUM(e.devengado), 0) FROM Ejecucion e WHERE e.presupuesto.idpresupuesto = :idpresupuesto")
    BigDecimal sumaDevengadoPorPartida(@Param("idpresupuesto") Short idpresupuesto);

    // Suma ejecucion.devengado para actualizar ejecucion.totdeven
    @Query("""
        SELECT COALESCE(SUM(e.devengado), 0)
        FROM Ejecucion e
        WHERE e.compromiso.idcompromiso = :idcompromiso
        """)
    BigDecimal sumaDevengadoPorIdcomprom(@Param("idcompromiso") Long idcompromiso);

    // Ejecuciones de un Asiento
    List<Ejecucion> findByIdasiento(Short idasiento);

    // Ejecución de una Transacción (es de 1 a 1)
    // Ejecucion findByTransaccion_Idtransaccion(Long idtransaccion);

    // Ejecución de una Transacción Optional
    Optional<Ejecucion> findByTransaccion(Long idtransaccion);

    // Ejecuciones de un idcomprom (Devengados de un compromiso)
    List<Ejecucion> findByCompromiso_Idcompromiso(Long idcomprom);

    // === REPORTES ===
    // Auxiliar presupuestario de ingreso
    @Query("""
             SELECT e
             FROM Ejecucion e
             JOIN e.presupuesto p
             JOIN p.proyecto pr
             WHERE pr.codigo = :codigoProyecto
               AND p.codpar = :codpar
               AND e.fecha BETWEEN :desde AND :hasta
             ORDER BY e.fecha
         """)
    List<Ejecucion> findEjecucionByProyectoAndCodparAndFecha(
            String codigoProyecto,
            String codpar,
            LocalDate desde,
            LocalDate hasta);

}

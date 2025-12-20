package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Partixcerti;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public interface PartixcertiR extends JpaRepository<Partixcerti, Long> {

    // Partidas por Certificacion
    List<Partixcerti> findByCertificacion_Idcertificacion(Short idcertificacion);

    // Suma partixcerti.valor para actualizar certificaciones.total
    @Query("SELECT COALESCE(SUM(p.valor), 0) FROM Partixcerti p WHERE p.certificacion.idcertificacion = :idcertificacion")
    BigDecimal sumaValorPorCertificacion(@Param("idcertificacion") Short idcertificacion);

    // Suma partixcerti.valor para actualizar presupuesto.totcerti
    @Query("SELECT COALESCE(SUM(p.valor), 0) FROM Partixcerti p WHERE p.presupuesto.idpresupuesto = :idpresupuesto")
    BigDecimal sumaValorPorPartida(@Param("idpresupuesto") Short idpresupuesto);

    // Partixcerti que tienen saldo hasta una fecha y numero desde/hasta
    @Query("""
            SELECT p FROM Partixcerti p
            WHERE p.certificacion.fecha < :fechaHasta
              AND p.certificacion.numero BETWEEN :numDesde AND :numHasta
              AND p.valor > p.totprmisos order by p.certificacion.numero
         """)
    List<Partixcerti> findByPartixcertiConSaldo(
            @Param("fechaHasta") LocalDate fechaHasta,
            @Param("numDesde") int numDesde,
            @Param("numHasta") int numHasta);

    // Cuenta las partixcerti de un Partida
    short countByPresupuesto_Idpresupuesto(Short idpresupuesto);

    // Cuenta las partixcerti de una Certificación
    short countByCertificacion_Idcertificacion(Short idcertificacion);

    // Certificaciones de una Partida en un rango de fechas
    List<Partixcerti> findByPresupuesto_IdpresupuestoAndCertificacion_FechaBetweenOrderByCertificacion_Fecha(
            Short idpresupuesto, LocalDate fechaDesde, LocalDate fechaHasta);

}
package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Asientos;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public interface AsientosR extends JpaRepository<Asientos, Short> {

    // Busca asientos desde/hasta por números y fecha
    List<Asientos> findByNumeroBetweenAndFechaBetweenOrderByNumeroAsc(
            long desdeNum, long hastaNum, LocalDate desdeFecha, LocalDate hastaFecha);

    // Último registro completo por número
    Asientos findTopByOrderByNumeroDesc();

    // Ultima Fecha
    @Query("SELECT MAX(a.fecha) FROM Asientos a")
    LocalDate findUltimaFecha();

    // Ultimo comprobante
    @Query("SELECT MAX(a.compro) FROM Asientos a WHERE a.tipcom = :tipcom")
    Long findLastComproByTipcom(@Param("tipcom") Byte tipcom);

    // Valida número de comprobante
    boolean existsByTipcomAndCompro(Byte tipcom, Long compro);

    // Actualiza totdeb y totcre
    @Modifying
    @Transactional
    @Query("UPDATE Asientos a SET a.totdeb = :totdeb, a.totcre = :totcre WHERE a.idasiento = :idasiento")
    int updateTotalesById(
            @Param("totdeb") BigDecimal totdeb,
            @Param("totcre") BigDecimal totcre,
            @Param("idasiento") short idasiento);

    @Modifying
    @Transactional
    @Query("UPDATE Asientos a SET a.totdeb = :totdeb, a.totcre = :totcre WHERE a.idasiento = :idasiento")
    void updateTotdebAndTotcre(@Param("idasiento") Short idasiento, @Param("totdeb") BigDecimal totdeb, @Param("totcre") BigDecimal totcre);

}

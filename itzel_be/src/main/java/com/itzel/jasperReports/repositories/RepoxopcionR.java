package com.itzel.jasperReports.repositories;

import com.itzel.jasperReports.modelo.Repoxopcion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface RepoxopcionR extends JpaRepository<Repoxopcion, Short> {

    // Busca Repoxopcion
    List<Repoxopcion> findByCodigoStartingWithAndOpcionContainingIgnoreCaseAndNombreContainingIgnoreCaseOrderByCodigoAsc(
            String codigo, String opcion, String nombre);

    // Repoxopcion para datalist por Código
    List<Repoxopcion> findByCodigoStartingWithOrderByCodigo(String codigo);

    // Repoxopcion por Código y Largo
    @Query("SELECT r FROM Repoxopcion r WHERE LENGTH(r.codigo) = :largo AND r.codigo LIKE CONCAT(:codigo, '%') ORDER BY r.codigo")
    List<Repoxopcion> findByCodigoStartingWithAndLength(
            @Param("codigo") String codigo,
            @Param("largo") int largo
    );

    // Valida codigo
    boolean existsByCodigo(String codigo);

    // Valida nombre
    boolean existsByNombreIgnoreCase(String nombre);

}

package com.itzel.jasperReports.repositories;

import com.itzel.jasperReports.modelo.Reportesjr;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReportesjrR extends JpaRepository<Reportesjr, Short> {
    // Buscar reportesjr por opcion, nombre y desrep ordenados por codrep
    List<Reportesjr> findByRepoxopcion_CodigoStartingWithAndNomrepContainingIgnoreCaseAndDesrepContainingIgnoreCaseOrderByRepoxopcion_CodigoAsc(
            String codigo, String nomrep, String desrep);

    // Reportes de un nomrep específico
    List<Reportesjr> findByNomrepStartingWithOrderByNomrep(String nomrepBase);

    // Busca un Reporte por nomrep,
    Reportesjr findByNomrep(String nomrep);

    // Valida si existe un nomrep
    boolean existsByNomrep(String nomrep);

    // Buscar todos los reportes con un Repoxopcion_Codigo específico
    List<Reportesjr> findByRepoxopcion_CodigoOrderByNomrep(String codigo);
}

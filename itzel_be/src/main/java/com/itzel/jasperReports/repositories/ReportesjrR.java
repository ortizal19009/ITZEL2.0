package com.itzel.jasperReports.repositories;

import com.itzel.jasperReports.modelo.Reportesjr;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportesR extends JpaRepository<Reportesjr, Long> {
    Reportesjr findByNombre(String nombre);
    boolean existsByNombre(String nombre);
}

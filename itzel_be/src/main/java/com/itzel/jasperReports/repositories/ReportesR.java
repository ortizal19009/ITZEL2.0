package com.itzel.jasperReports.repositories;

import com.itzel.jasperReports.modelo.Reportes;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportesR extends JpaRepository<Reportes, Long> {
    Reportes findByNombre(String nombre);

}

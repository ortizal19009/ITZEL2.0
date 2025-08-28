package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Cargos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CargosR extends JpaRepository<Cargos, Long> {
    // Todos los Cargos ordenados por nomcargo
    List<Cargos> findAllByOrderByNomcargoAsc();

    // Validar si existe un nomcargo (ignorando mayúsculas y minúsculas)
    boolean existsByNomcargoIgnoreCase(String nomcargo);
}

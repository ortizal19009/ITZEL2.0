package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Destinos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DestinosR extends JpaRepository<Destinos, Short> {

    // Todas las Destinos ordenadas por nomdestino
    List<Destinos> findAllByOrderByNomdestinoAsc();

    // Validar si existe un nomdestino (ignorando mayúsculas y minúsculas)
    boolean existsByNomdestinoIgnoreCase(String nomdestino);

}

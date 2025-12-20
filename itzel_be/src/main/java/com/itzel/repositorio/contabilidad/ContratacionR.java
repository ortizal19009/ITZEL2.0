package com.itzel.repositorio.contabilidad;


import com.itzel.modelo.contabilidad.Contratacion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContratacionR extends JpaRepository<Contratacion, Short> {

    // Todos los Tipos de contratacion ordenados por nombre
    List<Contratacion> findAllByOrderByNombreAsc();

    // Validar si existe un nombre (ignorando mayúsculas y minúsculas)
    boolean existsByNombreIgnoreCase(String nombre);

}

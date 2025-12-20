package com.itzel.repositorio.contabilidad;


import com.itzel.modelo.contabilidad.Departamentos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DepartamentosR extends JpaRepository<Departamentos, Short> {

    // Todos los Departamentos ordenados por nomdep
    List<Departamentos> findAllByOrderByNomdepAsc();

}

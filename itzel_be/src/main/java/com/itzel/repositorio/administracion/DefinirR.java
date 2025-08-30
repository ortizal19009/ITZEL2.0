package com.itzel.repositorio.administracion;

import com.itzel.modelo.administracion.Definir;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DefinirR extends JpaRepository<Definir, Long> {
    DefinirR findTopByOrderByIddefinirDesc();
}

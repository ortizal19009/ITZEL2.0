package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Estructura;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface EstructuraR extends JpaRepository<Estructura, Short> {

    // Devuelve la entidad con el nivel más alto
    Estructura findTopByOrderByNivelDesc();

    // Devuelve todas las entidades con un nivel específico
    List<Estructura> findByNivel(Integer nivel);

}

package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Articulos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticulosR extends JpaRepository<Articulos, Short> {

    // Buscar artículos por: codigo, codcue y nombre, o una combinación
    List<Articulos> findByCodigoContainingIgnoreCaseAndCodcueStartingWithAndNombreContainingIgnoreCaseOrderByCodigoAsc(
            String codigo, String codcue, String nombre);

    // Valida el Nombre
    boolean existsByNombreIgnoreCase(String nombre);

    // Valida el código
    boolean existsByCodigo(String codigo);

}

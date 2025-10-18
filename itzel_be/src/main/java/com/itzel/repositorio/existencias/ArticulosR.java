package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Articulos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArticulosR extends JpaRepository<Articulos, Short> {

    // Buscar artículos por: codigo, codcue y nombre, o una combinación
    List<Articulos> findByCodigoContainingIgnoreCaseAndCodcueStartingWithAndNombreContainingIgnoreCaseOrderByCodigoAsc(
            String codigo, String codcue, String nombre);
    // Buscar artículos por: codigo, codcue o nombre en un solo campo.
    @Query("""
    SELECT a FROM Articulos a
    WHERE a.actual > 0
      AND LOWER(COALESCE(a.nombre, '')) LIKE LOWER(CONCAT('%', :q, '%'))
    """)
    List<Articulos> buscarPorNombre(@Param("q") String q);

    @Query("""
    SELECT a FROM Articulos a
    WHERE a.actual > 0
      AND LOWER(COALESCE(a.codigo, '')) LIKE LOWER(CONCAT('%', :q, '%'))
    """)
    List<Articulos> buscarPorCodigo(@Param("q") String q);

    @Query("""
    SELECT a FROM Articulos a
    WHERE a.actual > 0
      AND LOWER(COALESCE(a.codcue, '')) LIKE LOWER(CONCAT('%', :q, '%'))
    """)
    List<Articulos> buscarPorCodcue(@Param("q") String q);


    // Valida el Nombre
    boolean existsByNombreIgnoreCase(String nombre);

    // Valida el código
    boolean existsByCodigo(String codigo);

}

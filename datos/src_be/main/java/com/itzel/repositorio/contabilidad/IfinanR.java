package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Ifinan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface IfinanR extends JpaRepository<Ifinan, Long> {
    // Lista de Instituciones (Búsqueda por Código)
    @Query(value = "SELECT * FROM ifinan WHERE codifinan LIKE ?1% order by codifinan", nativeQuery = true)
    List<Ifinan> findByCodifinan(String codifinan);

    // Lista de Instituciones (Búsqueda por Nombre)
    @Query(value = "SELECT * FROM ifinan WHERE LOWER(nomifinan) LIKE %?1% order by nomifinan", nativeQuery = true)
    List<Ifinan> findByNomifinan(String nomifinan);
    // Lista de Instituciones (Búsqueda por Código)
    @Query(value = "SELECT * FROM ifinan WHERE codifinan = ?1 order by codifinan", nativeQuery = true)
    Ifinan findCodifinan(String codifinan);

    // Lista de Instituciones (Búsqueda por Nombre)
    @Query(value = "SELECT * FROM ifinan WHERE LOWER(nomifinan) = ?1 order by nomifinan", nativeQuery = true)
    Ifinan findNomifinan(String nomifinan);

}

package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ClasificadorR extends JpaRepository<Clasificador, Long> {
    @Query(value = "SELECT * FROM clasificador c WHERE (c.codpar like ?1% or c.nompar like %?1% )and c.nivpar = 4", nativeQuery = true)
    public List<Clasificador> findByCodOrNom(String dato);
}

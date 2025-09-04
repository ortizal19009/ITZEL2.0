package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ClasificadorR extends JpaRepository<Clasificador, Short> {
    @Query(value = "SELECT * FROM clasificador c WHERE (c.codpar like ?1% or c.nompar like %?1% )and c.nivpar = 4", nativeQuery = true)
    public List<Clasificador> findByCodOrNom(String dato);
    // Busca Partidas de clasificador por codpar o nompar ordenadas por codpar
    List<Clasificador> findByCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(String codpar, String nompar);
    // Valida codpar
    boolean existsByCodpar(String codpar);

    // Valida nompar
    boolean existsByNomparIgnoreCase(String nompar);

    // Partidas de ingresos del clasificador para datalist
    @Query("SELECT c FROM Clasificador c WHERE c.nivpar = 4 AND c.codpar < '4' AND c.codpar like :codpar ORDER BY c.codpar ASC")
    List<Clasificador> findPartidasing(@Param("codpar") String codpar);
}

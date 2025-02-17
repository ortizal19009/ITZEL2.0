package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CuentasR extends JpaRepository<Cuentas, Long> {
    //Consulta personalizada con paginación
    @Query(value = "SELECT * FROM cuentas ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByCodcue(Pageable pageable);
    //Consulta personalizada con paginación
    @Query(value = "SELECT * FROM cuentas WHERE codcue like ?1% ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByCod(String codcue, Pageable pageable);
    @Query(value = "SELECT * FROM cuentas WHERE LOWER(nomcue) like %?1% ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByDenom(String nomcue, Pageable pageable);
}

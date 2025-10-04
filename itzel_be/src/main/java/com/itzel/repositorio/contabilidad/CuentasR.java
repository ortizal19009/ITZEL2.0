package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface CuentasR extends JpaRepository<Cuentas, Long> {
    //Consulta personalizada con paginación
    @Query(value = "SELECT * FROM cuentas ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByCodcue(Pageable pageable);
    //Consulta personalizada con paginación
    @Query(value = "SELECT * FROM cuentas WHERE codcue like ?1% ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByCod(String codcue, Pageable pageable);
    @Query(value = "SELECT * FROM cuentas WHERE LOWER(nomcue) like %?1% ORDER BY codcue asc", nativeQuery = true)
    public Page<Cuentas> findByDenom(String nomcue, Pageable pageable);
    //buscar una sola cuenta por el codigo cuenta (codcue)
    Optional<Cuentas> findByCodcue(String codcue);
    //Cuentas para datalist
    //List<Cuentas> findByTiptranAndCodcueStartingWithOrderByCodcue(short tiptran, String codcue);
    List<Cuentas> findByTiptranAndCodcueStartingWithAndMovcueTrueOrderByCodcue(short tiptran, String codcuePrefix);



}

package com.amon_ra.repositorio.contabilidad;

import com.amon_ra.modelo.contabilidad.Estrfunc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EstrfuncR extends JpaRepository<Estrfunc, Long> {
    @Query(value = "SELECT * FROM estrfunc ef WHERE ef.codigo = ?1 ", nativeQuery = true)
    Estrfunc findByCodigo(String codigo);
    @Query(value = "SELECT * FROM estrfunc ef WHERE ef.nombre = ?1 ", nativeQuery = true)
    Estrfunc findByNombre(String nombre);
    @Query(value = "SELECT * FROM estrfunc ef WHERE ef.codigo = ?1 and ef.idestructura_estructura = ?2", nativeQuery = true)
    Estrfunc findByCodigoAndEstructura(String codigo, Long estructura);
    @Query(value = "SELECT * FROM estrfunc ef WHERE ef.idestructura_estructura = ?2", nativeQuery = true)
    Estrfunc findByEstructura(String codigo, Long estructura);
    
}

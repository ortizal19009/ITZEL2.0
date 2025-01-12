package com.amon_ra.repositorio.contabilidad;

import com.amon_ra.modelo.contabilidad.Proyectos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProyectosR extends JpaRepository<Proyectos, Long> {
    @Query(value = "SELECT * FROM proyectos p WHERE p.codigo = ?1 ", nativeQuery = true)
    Proyectos findByCodigo(String codigo);
    @Query(value = "SELECT * FROM proyectos p WHERE p.codigo LIKE ?1% order by codigo asc ", nativeQuery = true)
    List<Proyectos> findByCodigoMayor(String codigo);
    @Query(value = "SELECT * FROM proyectos p WHERE p.nombre = ?1 ", nativeQuery = true)
    Proyectos findByNombre(String nombre);
    @Query(value = "SELECT * FROM proyectos p WHERE p.codigo = ?1 and ef.idestructura_estructura = ?2", nativeQuery = true)
    Proyectos findByCodigoAndEstructura(String codigo, Long estructura);
    @Query(value = "SELECT * FROM proyectos p WHERE p.idestructura_estructura = ?1", nativeQuery = true)
    Proyectos findByEstructura(Long estructura);
    @Query(value = "SELECT COUNT(p) FROM Proyectos p WHERE p.codigo > ?1", nativeQuery = true)
    int countByCodigoMayor(String codigo);


}

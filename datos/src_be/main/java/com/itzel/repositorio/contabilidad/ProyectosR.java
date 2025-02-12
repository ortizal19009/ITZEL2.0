package com.itzel.repositorio.contabilidad;

import com.itzel.interfaces.contabilidad.Proyectos_rep_int;
import com.itzel.modelo.contabilidad.Proyectos;
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
    @Query(value = "SELECT * FROM proyectos p WHERE (p.codigo like ?1% or p.nombre like %?1%) and p.idestructura  = 3 ", nativeQuery = true)
    List<Proyectos> findByCodNom(String dato);
    @Query(value = "SELECT * FROM proyectos p WHERE p.codigo = ?1 and ef.idestructura = ?2", nativeQuery = true)
    Proyectos findByCodigoAndEstructura(String codigo, Long estructura);
    @Query(value = "SELECT * FROM proyectos p WHERE p.idestructura = ?1", nativeQuery = true)
    Proyectos findByEstructura(Long estructura);
    @Query(value = "SELECT COUNT(p) FROM Proyectos p WHERE p.codigo > ?1", nativeQuery = true)
    int countByCodigoMayor(String codigo);
    @Query(value = "SELECT p.codigo, p.nombre as nombreproyecto, p.movimiento, e.nivel, e.nombre as nombreestructura  FROM proyectos p JOIN estructura e ON p.idestructura = e.idestructura WHERE e.nivel = ?1 ORDER BY p.codigo ASC", nativeQuery = true)
    List<Proyectos_rep_int> findByNivel(Long nivel);
    @Query(value = "SELECT p.codigo, p.nombre as nombreproyecto, p.movimiento, e.nivel, e.nombre as nombreestructura  FROM proyectos p JOIN estructura e ON p.idestructura = e.idestructura WHERE p.codigo LIKE ?1% ORDER BY p.codigo ASC", nativeQuery = true)
    List<Proyectos_rep_int> findByGrupo(String codigo);

}

package com.itzel.repositorio.administracion;

import com.itzel.modelo.administracion.Ventanas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface VentanasR extends JpaRepository<Ventanas, Long> {
    @Query("SELECT v FROM Ventanas v WHERE v.idusuario = :idusuario AND v.nombre = :nombre")
    Ventanas findByIdusuarioAndNombre(@Param("idusuario") Long idusuario, @Param("nombre") String nombre);
}

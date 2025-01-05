package com.amon_ra.repositorio.contabilidad;

import com.amon_ra.modelo.contabilidad.Estrfunc;
import com.amon_ra.modelo.contabilidad.Estructura;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EstructuraR extends JpaRepository<Estructura, Long> {

}

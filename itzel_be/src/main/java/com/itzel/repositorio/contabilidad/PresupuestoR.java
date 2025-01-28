package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PresupuestoR extends JpaRepository<Presupuesto, Long> {
}

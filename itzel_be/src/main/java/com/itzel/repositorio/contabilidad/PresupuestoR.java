package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PresupuestoR extends JpaRepository<Presupuesto, Long> {
    @Query(value = "SELECT * FROM presupuesto p WHERE p.tippar = ?1 ORDER BY p.codpar",nativeQuery = true)
    public Page<Presupuesto> findByTipparPageable(int tippar, Pageable pageable);
}

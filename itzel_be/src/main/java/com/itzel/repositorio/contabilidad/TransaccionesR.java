package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Transacciones;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransaccionesR extends JpaRepository<Transacciones, Long> {

    // Transacciones por Asiento
    List<Transacciones> findByAsiento_IdasientoOrderByOrden(Short idasiento);

}

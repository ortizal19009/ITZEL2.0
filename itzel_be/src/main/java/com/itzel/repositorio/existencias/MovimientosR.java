package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Movimientos;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovimientosR extends JpaRepository<Movimientos, Short> {
}

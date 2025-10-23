package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Movimientos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MovimientosR extends JpaRepository<Movimientos, Short> {
    //Buscar los movimientos por tipo de movimiento (ingreso ó salida)
    List<Movimientos> findByTipmov(Short tipmov);
}

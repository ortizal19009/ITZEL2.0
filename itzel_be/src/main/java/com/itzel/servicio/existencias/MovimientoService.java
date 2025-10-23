package com.itzel.servicio.existencias;

import com.itzel.repositorio.existencias.MovimientosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MovimientoService {
    private final MovimientosR dao;
}

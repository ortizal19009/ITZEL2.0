package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Departamentos;
import com.itzel.repositorio.contabilidad.DepartamentosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class DepartamentoService {

    private final DepartamentosR dao;

    // Todos los Departamentos ordenados por nomdep
    public List<Departamentos> obtenerOrdenadosPorNomdep() {
        return dao.findAllByOrderByNomdepAsc();
    }

}

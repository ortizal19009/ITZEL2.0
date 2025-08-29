package com.itzel.servicio.administracion;

import com.itzel.modelo.administracion.Eliminados;
import com.itzel.repositorio.administracion.EliminadosR;
import org.springframework.stereotype.Service;

@Service
public class EliminadoService {

    private final EliminadosR dao;

    public EliminadoService(EliminadosR dao) {
        this.dao = dao;
    }

    // Guardar nuevo
    public <S extends Eliminados> S save(S entity) {
        return dao.save(entity);
    }
}

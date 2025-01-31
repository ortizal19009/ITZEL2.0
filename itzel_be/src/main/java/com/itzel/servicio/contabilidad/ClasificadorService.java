package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import com.itzel.repositorio.contabilidad.ClasificadorR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClasificadorService {
    @Autowired
    private ClasificadorR dao;
    public List<Clasificador> findAll(){
        return dao.findAll();
    }
}

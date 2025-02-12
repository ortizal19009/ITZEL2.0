package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Niveles;
import com.itzel.repositorio.contabilidad.NivelesR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NivelesService {
    @Autowired
    private NivelesR dao;
    public List<Niveles> findAll(){
        return dao.findAll();
    }

}

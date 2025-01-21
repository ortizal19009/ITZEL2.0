package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Estructura;
import com.itzel.repositorio.contabilidad.EstructuraR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EstructuraService {
    @Autowired
    private EstructuraR dao;

    public List<Estructura> findAll(){
        return dao.findAll();
    }
}

package com.amon_ra.servicio.contabilidad;

import com.amon_ra.modelo.contabilidad.Estructura;
import com.amon_ra.repositorio.contabilidad.EstructuraR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EstructuraService {
    private final EstructuraR dao;

    public EstructuraService(EstructuraR dao) {
        this.dao = dao;
    }


    public List<Estructura> findAll(){
        return dao.findAll();
    }
}

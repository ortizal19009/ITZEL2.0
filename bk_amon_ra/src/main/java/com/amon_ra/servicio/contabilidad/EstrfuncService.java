package com.amon_ra.servicio.contabilidad;

import com.amon_ra.modelo.contabilidad.Estrfunc;
import com.amon_ra.repositorio.contabilidad.EstrfuncR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EstrfuncService {
    @Autowired
    private EstrfuncR dao;

    public List<Estrfunc> findAll(){
        return dao.findAll();
    }

}

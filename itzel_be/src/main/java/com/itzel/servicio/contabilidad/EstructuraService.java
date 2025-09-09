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
    // Devuelve la entidad con el nivel más alto
    public Estructura findTopByOrderByNivelDesc(){
        return dao.findTopByOrderByNivelDesc();
    }
    // Devuelve todas las entidades con un nivel específico
    public List<Estructura> findByNivel(Integer nivel){
        return dao.findByNivel(nivel);
    }
}

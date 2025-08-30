package com.itzel.servicio.administracion;

import com.itzel.modelo.administracion.Ventanas;
import com.itzel.repositorio.administracion.VentanasR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class VentanasService {

    @Autowired
    private VentanasR dao;

    public Ventanas findVentana(Long idusuario, String nombre) {
        return dao.findByIdusuarioAndNombre(idusuario, nombre);
    }

    public <S extends Ventanas> S save(S x) {
        return dao.save( x );
    }

    public Optional<Ventanas> findById(Long id) {
        return dao.findById(id);
    }

}

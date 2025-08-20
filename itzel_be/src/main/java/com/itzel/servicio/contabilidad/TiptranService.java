package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Tiptran;
import com.itzel.repositorio.contabilidad.TiptranR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TiptranService {
    @Autowired
    private TiptranR dao;

    public List<Tiptran> findAll(){
       return dao.findAll();
    }
}

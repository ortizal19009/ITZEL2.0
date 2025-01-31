package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.repositorio.contabilidad.PresupuestoR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PresupuestoService {
    @Autowired
    private PresupuestoR dao;
    public Page<Presupuesto> findAllByPage(int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return dao.findAll(pageable);
    }

    public Page<Presupuesto> findByTipparPageable(int tippar, int page, int size){
        Pageable pageable= PageRequest.of(page, size);
        return dao.findByTipparPageable(tippar, pageable);

    }

}

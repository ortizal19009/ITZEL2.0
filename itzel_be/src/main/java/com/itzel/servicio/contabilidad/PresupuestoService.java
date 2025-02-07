package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.repositorio.contabilidad.PresupuestoR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
    public Presupuesto save(Presupuesto presupuesto){
        return dao.save(presupuesto);
    }
    public Presupuesto findByCodPar(String codpar){
        return dao.findByCodpar(codpar);
    }
    public Optional<Presupuesto> findById(Long idpresupuesto){
        return dao.findById(idpresupuesto);
    }

}

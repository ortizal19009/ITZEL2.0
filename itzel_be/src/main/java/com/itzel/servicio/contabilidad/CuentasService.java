package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import com.itzel.repositorio.contabilidad.CuentasR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CuentasService {
    @Autowired
    private CuentasR dao;

    public List<Cuentas> findAll(){
        return dao.findAll();
    }
    public Cuentas saveOne(Cuentas c){
        return dao.save(c);
    }
    public Map<String, Object> save(Cuentas c) {
        Map<String, Object> response = new HashMap<>();
        Cuentas _cuetna = dao.findById(c.getIdcuenta()).orElse(null);
        if (Objects.equals(_cuetna.getCodcue(), c.getCodcue()) || Objects.equals(_cuetna.getNomcue(), c.getNomcue())) {
            response.put("message", "Los datos ya existen. No se puede crear datos duplicados");
            response.put("status", "error");

        } else {
            Cuentas cuentaSaved = dao.save(c);
            response.put("message", "Los datos fueron guardados con exito");
            response.put("status", "success");
            response.put("body", cuentaSaved);
        }
        return response;
    }
    public Page<Cuentas> getCuentasByPage( int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return dao.findByCodcue( pageable);
    }
    public Page<Cuentas> findByCod(String codcue, int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return dao.findByCod(codcue, pageable);
    }
    public Page<Cuentas> findByDenom(String nomcue, int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return dao.findByDenom(nomcue, pageable);
    }
    public Optional<Cuentas> findById(Long idcuenta){
        return dao.findById(idcuenta);
    }
    //buscar una sola cuenta por el codigo cuenta (codcue)
    public Optional<Cuentas> findByCodcue(String codcue){
        return dao.findByCodcue(codcue);
    }

    // Cuentas para datalist
    public List<Cuentas> recuperaPorTiptranYCodcue(short tiptran, String codcue) {
        return dao.findByTiptranAndCodcueStartingWithAndMovcueTrueOrderByCodcue(tiptran, codcue);
    }
}

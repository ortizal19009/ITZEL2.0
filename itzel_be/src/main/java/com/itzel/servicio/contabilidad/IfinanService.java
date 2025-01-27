package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Ifinan;
import com.itzel.repositorio.contabilidad.IfinanR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class IfinanService {
    @Autowired
    IfinanR dao;

    public List<Ifinan> findByCodifinan(String codifinan) {
        return dao.findByCodifinan( codifinan );
    }

    public List<Ifinan> findByNomifinan(String nomifinan) {
        return dao.findByNomifinan( nomifinan );
    }

    public <S extends Ifinan> S save(S entity) {
        return dao.save(entity);
    }
     public Map<String, Object> saveIfinan(Ifinan ifinan){
         Map<String, Object> response = new HashMap<>();
         Ifinan bycode = dao.findCodifinan(ifinan.getCodifinan());
         Ifinan bynom = dao.findNomifinan(ifinan.getNomifinan().toLowerCase());
         if(ifinan.getCodifinan().length() != 8){
             response.put("message", "Error en longitud del codigo");
             response.put("status", "error");
             return response;
         }
            if( bycode == null && bynom == null){
                response.put("message", "Datos guardados con éxito");
                response.put("status", "success");
                response.put("body", dao.save(ifinan));
            }else{
                response.put("message", "Error al guardar datos");
                response.put("status", "error");
                response.put("body","Datos repetidos");
            }
         return response;
     }

    public List<Ifinan> findAll(Sort sort) {
        return dao.findAll(sort);
    }

    public Page<Ifinan> findAll(Pageable pageable) {
        return dao.findAll(pageable);
    }

    public Optional<Ifinan> findById(Long id) {
        return dao.findById(id);
    }

    // public Boolean deleteById(Long id) {
    //    if (dao.existsById(id)) {
    //       dao.deleteById(id);
    //       return !dao.existsById(id);
    //    }
    //    return false;
    // }

    public void delete(Ifinan entity) {
        dao.delete(entity);
    }
}

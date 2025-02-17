package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Gruposbene;
import com.itzel.repositorio.contabilidad.GruposbeneR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GrupobeneService {
    @Autowired
    GruposbeneR dao;

    public List<Gruposbene> findByNomgru(String nomgru) {
        return dao.findByNomgru(nomgru);
    }

    public <S extends Gruposbene> S save(S entity) {
        return dao.save(entity);
    }

    public List<Gruposbene> findAll(Sort sort) {
        return dao.findAll(sort);
    }

    public Page<Gruposbene> findAll(Pageable pageable) {
        return dao.findAll(pageable);
    }

    public List<Gruposbene> findAll() {
        return dao.findAll();
    }

    //Un registro
    public Gruposbene findByIdgrupo(Long idgrupo) {
        return dao.findByIdgrupo(idgrupo);
    }

    public Optional<Gruposbene> findById(Long id) {
        return dao.findById(id);
    }

    public Boolean deleteById(Long id) {
        if (dao.existsById(id)) {
            dao.deleteById(id);
            return !dao.existsById(id);
        }
        return false;
    }

    public void delete(Gruposbene entity) {
        dao.delete(entity);
    }
}

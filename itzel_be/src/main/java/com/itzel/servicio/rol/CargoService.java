package com.itzel.servicio.rol;

import com.itzel.modelo.rol.Cargos;
import com.itzel.repositorio.rol.CargosR;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CargoService {

    private final CargosR dao;

    public CargoService(CargosR dao) {
        this.dao = dao;
    }

    // Todos los Cargos ordenados por nomcargo
    public List<Cargos> obtenerCargosOrdenadosPorNomcargo() {
        return dao.findAllByOrderByNomcargoAsc();
    }

    // Validar si existe un nomcargo (ignorando mayúsculas y minúsculas)
    public boolean existeNomcargo(String nomcargo) {
        return dao.existsByNomcargoIgnoreCase(nomcargo);
    }

    // Guardar nuevo
    public <S extends Cargos> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por id
    public Optional<Cargos> findById(Short idcargo) {
        return dao.findById(Long.valueOf(idcargo));
    }

    // Actualiza
    public Cargos actualizar(Short idcargo, Cargos x) {
        Optional<Cargos> y = dao.findById(Long.valueOf(idcargo));
        if (y.isPresent()) {
            Cargos cargos = y.get();
            cargos.setNomcargo(x.getNomcargo());
            cargos.setValor(x.getValor());
            cargos.setUsumodi(x.getUsumodi());
            cargos.setFecmodi(x.getFecmodi());
            return dao.save(cargos);
        } else {
            throw new RuntimeException("Cargos no encontrado con id " + idcargo);
        }
    }

    // Elimina
    public void deleteById(Short idcargo) {
        dao.deleteById(Long.valueOf(idcargo));
    }

}
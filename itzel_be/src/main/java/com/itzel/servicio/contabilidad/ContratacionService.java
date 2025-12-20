package com.itzel.servicio.contabilidad;


import com.itzel.modelo.contabilidad.Contratacion;
import com.itzel.repositorio.contabilidad.ContratacionR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContratacionService {

    private final ContratacionR dao;

    // Todos los Tipo de Contratacion ordenados por nombre
    public List<Contratacion> obtenerPorNombre() {
        return dao.findAllByOrderByNombreAsc();
    }

    // Validar si existe un nombre (ignorando mayúsculas y minúsculas)
    public boolean existeNombre(String nombre) {
        return dao.existsByNombreIgnoreCase(nombre);
    }

    // Guardar nuevo
    public <S extends Contratacion> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por id
    public Optional<Contratacion> findById(Short idcontratacion) {
        return dao.findById(idcontratacion);
    }

    // Actualizar
    public Contratacion actualizarContratacion(Short idcontratacion, Contratacion x) {
        Optional<Contratacion> y = dao.findById(idcontratacion);
        if (y.isPresent()) {
            Contratacion contratacion = y.get();
            contratacion.setNombre(x.getNombre());
            contratacion.setUsumodi(x.getUsumodi());
            contratacion.setFecmodi(x.getFecmodi());

            return dao.save(contratacion);
        } else {
            throw new RuntimeException("Contratacion no encontrada con id " + idcontratacion);
        }
    }

    // Elimina
    public void deleteById(Short idcontratacion) {
        dao.deleteById(idcontratacion);
    }

}

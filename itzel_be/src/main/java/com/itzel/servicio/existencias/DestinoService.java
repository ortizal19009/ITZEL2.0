package com.itzel.servicio.existencias;


import com.itzel.modelo.existencias.Destinos;
import com.itzel.repositorio.existencias.DestinosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class DestinoService {

    private final DestinosR dao;

    // Todas los Destinos ordenadas por nomdestino
    public List<Destinos> obtenerDestinosOrdenadasPorNomdestino() {
        return dao.findAllByOrderByNomdestinoAsc();
    }

    // Validar si existe un nomdestino (ignorando mayúsculas y minúsculas)
    public boolean existeNomdestino(String nomdestino) {
        return dao.existsByNomdestinoIgnoreCase(nomdestino);
    }

    // Guardar nuevo
    public <S extends Destinos> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por id
    public Optional<Destinos> findById(Short iddestino) {
        return dao.findById(iddestino);
    }

    // Actualiza
    public Destinos actualizar(Short iddestino, Destinos x) {
        Optional<Destinos> y = dao.findById(iddestino);
        if (y.isPresent()) {
            Destinos dest = y.get();
            dest.setNomdestino(x.getNomdestino());
            dest.setUsumodi(x.getUsumodi());
            dest.setFecmodi(x.getFecmodi());
            return dao.save(dest);
        } else {
            throw new RuntimeException("Destinos no encontrado con id " + iddestino);
        }
    }

    // Elimina
    public void deleteById(Short iddestino) {
        dao.deleteById(iddestino);
    }

}

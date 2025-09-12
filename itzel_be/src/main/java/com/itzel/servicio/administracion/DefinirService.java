package com.itzel.servicio.administracion;

import com.itzel.modelo.administracion.Definir;
import com.itzel.repositorio.administracion.DefinirR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DefinirService {
    @Autowired
    private DefinirR dao;

    @SuppressWarnings("null")
    public Optional<Definir> findById(Long id) {
        return dao.findById(id);
    }

    @SuppressWarnings("null")
    public <S extends Definir> S save(S entity) {
        return dao.save(entity);
    }
    // Actualizar
    public Definir actualizarDefinir(Long iddefinir, Definir x) {
        Optional<Definir> y = dao.findById(iddefinir);
        if (y.isPresent()) {
            Definir definir = y.get();
            definir.setEmpresa(x.getEmpresa());
            definir.setFechap(x.getFechap());
            definir.setF_i(x.getF_i());
            definir.setF_g(x.getF_g());

            return dao.save(definir);
        } else {
            throw new RuntimeException("Definir no encontrado con id " + iddefinir);
        }
    }

}

package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Benextran;
import com.itzel.repositorio.contabilidad.BenextranR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class BenextranService {

    private final BenextranR dao;

    // Recupera por Transaccion
    public List<Benextran> obtenerPorTransaccion(Long idtransaccion) {
        return dao.findByTransaccion_Idtransaccion(idtransaccion);
    }

    // Guarda nuevo
    public <S extends Benextran> S save(S entity) {
        return dao.save(entity);
    }

}

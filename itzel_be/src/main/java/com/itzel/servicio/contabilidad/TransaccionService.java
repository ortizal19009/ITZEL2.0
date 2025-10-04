package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Transacciones;
import com.itzel.repositorio.contabilidad.TransaccionesR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class TransaccionService {

    private final TransaccionesR dao;

    // Transacciones por Asiento
    public List<Transacciones> obtenerPorIdAsiento(Short idasiento) {
        return dao.findByAsiento_IdasientoOrderByOrden(idasiento);
    }

    // Guarda nuevo
    public <S extends Transacciones> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por idtransaccion
    public Optional<Transacciones> findById(Long idtransaccion) {
        return dao.findById(idtransaccion);
    }

    // Actualiza
    public Transacciones actualiza(Long idtransaccion, Transacciones x) {
        Optional<Transacciones> y = dao.findById(idtransaccion);
        if (y.isPresent()) {
            Transacciones transa = y.get();
            transa.setOrden(x.getOrden());
            transa.setTiptran(x.getTiptran());
            transa.setCodcue(x.getCodcue());

            transa.setDocumento(x.getDocumento());
            transa.setNumdoc(x.getNumdoc());
            transa.setDebcre(x.getDebcre());
            transa.setValor(x.getValor());
            transa.setConcepto(x.getConcepto());

            transa.setUsumodi(x.getUsumodi());
            transa.setFecmodi(x.getFecmodi());

            return dao.save(transa);
        } else {
            throw new RuntimeException("Transaccion no encontrada con id " + idtransaccion);
        }
    }

}

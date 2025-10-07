package com.itzel.servicio.contabilidad;


import com.itzel.modelo.contabilidad.Asientos;
import com.itzel.repositorio.contabilidad.AsientosR;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class AsientoService {

    private final AsientosR dao;

    // Busca asientos desde/hasta por números y fecha
    public List<Asientos> buscaByNumeroYFecha(long desdeNum, long hastaNum, LocalDate desdeFecha, LocalDate hastaFecha) {
        return dao.findByNumeroBetweenAndFechaBetweenOrderByNumeroAsc(desdeNum, hastaNum, desdeFecha, hastaFecha);
    }

    // Último número de Asiento
    public Long obtenerUltimoNumero() {
        Asientos ultimo = dao.findTopByOrderByNumeroDesc();
        if (ultimo != null) {
            long ultimoNumero = ultimo.getNumero();
            return ultimoNumero;
        } else
            return 1L;
    }

    // Siguiente número de Asiento
    public Long siguienteNumero() {
        Asientos ultimo = dao.findTopByOrderByNumeroDesc();
        if (ultimo != null) {
            long ultimoNumero = ultimo.getNumero();
            return ultimoNumero + 1;
        } else
            return 1L;
    }

    // Ultima Fecha
    public LocalDate obtenerUltimaFecha() {
        return dao.findUltimaFecha();
    }

    // Ultimo comprobante
    public Long findLastComproByTipcom(Byte tipcom) {
        return dao.findLastComproByTipcom(tipcom);
    }

    // Valida número de comprobante
    public boolean validarComprobante(Byte tipcom, Long compro) {
        return dao.existsByTipcomAndCompro(tipcom, compro);
    }

    // Guarda nuevo
    public <S extends Asientos> S save(S entity) {


        return dao.save(entity);
    }

    // Asiento por idasiento
    public Optional<Asientos> findById(Short idasiento) {
        return dao.findById(idasiento);
    }

    // Actualiza totdeb y totcre
    @Transactional
    public int actualizarTotales(short idasiento, BigDecimal nuevoTotDeb, BigDecimal nuevoTotCre) {
        int filasActualizadas = dao.updateTotalesById(
                nuevoTotDeb,
                nuevoTotCre,
                idasiento);
        // if (filasActualizadas == 0) {
        // // Opcional: Lanzar una excepción si el asiento no existe
        // // throw new ResourceNotFoundException("Asiento con ID " + idasiento + " no
        // encontrado.");
        // System.out.println("Advertencia: No se encontró el asiento con ID " +
        // idasiento);
        // }
        return filasActualizadas;
    }

    // Actualizar Totales del Asiento
    public void updateTotdebAndTotcre(Short idasiento, BigDecimal totdeb, BigDecimal totcre) {
        dao.updateTotdebAndTotcre(idasiento, totdeb, totcre );
    }

}

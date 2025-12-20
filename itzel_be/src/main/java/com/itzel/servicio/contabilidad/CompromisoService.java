package com.itzel.servicio.contabilidad;


import com.itzel.modelo.contabilidad.Compromisos;
import com.itzel.repositorio.contabilidad.CompromisosR;
import com.itzel.repositorio.contabilidad.EjecucionR;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class CompromisoService {

    private final CompromisosR dao;
    private final EjecucionR daoejecu;

    public List<Compromisos> buscaByNumeroYFechaYTipo(long desdeNum, long hastaNum, LocalDate desdeFecha,
                                                      LocalDate hastaFecha, short tipo) {
        return dao.findByNumeroBetweenAndFechaBetweenAndTipoOrderByNumero(desdeNum, hastaNum, desdeFecha, hastaFecha,
                tipo);
    }

    // public Long obtenerUltimoNumero(short tipo) {
    //    Compromisos ultimaCompromiso = dao.findFirstByTipoOrderByNumeroDesc(tipo);
    //    if (ultimaCompromiso != null) {
    //       long ultimoNumeroCompromiso = ultimaCompromiso.getNumero();
    //       return ultimoNumeroCompromiso;
    //    } else
    //       return 1L;
    // }

    // Busca el último número de Compromiso
    public Compromisos findLastByTipo(short tipo) {
        return dao.findFirstByTipoOrderByNumeroDesc(tipo);
    }

    // Siguiente número de reforma
    // public long obtenerSiguienteNumero(short tipo) {
    //    Compromisos ultimaCompromiso = dao.findTopByTipoOrderByNumeroDesc(tipo);
    //    if (ultimaCompromiso != null) {
    //       long ultimoNumeroCompromiso = ultimaCompromiso.getNumero();
    //       return ultimoNumeroCompromiso + 1;
    //    } else
    //       return 1L;
    // }

    // Valida numero
    public boolean valNumero(Short tipo, Long numero) {
        return dao.existsByTipoAndNumero(tipo, numero);
    }

    // Conteo por idcontratacion
    public short contarPorIdcontratacion(Short idcontratacion) {
        return dao.countByContratacion_Idcontratacion(idcontratacion);
    }

    // Cuenta cuantos Compromisos tiene un iddocumento
    public short contarPorIddocumento(Short iddocumento) {
        return dao.countByDocumento_Iddocumento(iddocumento);
    }

    // Busca pot tipo y número
    public Compromisos buscarPorTipoYNumero(short tipo, long numero) {
        return dao.findByTipoAndNumero(tipo, numero).orElse(null);
    }

    // Guarda nuevo
    public <S extends Compromisos> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por idclasificador
    public Optional<Compromisos> findById(Short idcompromiso) {
        return dao.findById(idcompromiso);
    }

    // Actualiza
    public Compromisos actualiza(Short idcompromiso, Compromisos x) {
        Optional<Compromisos> y = dao.findById(idcompromiso);
        if (y.isPresent()) {
            Compromisos compromiso = y.get();
            compromiso.setTipo(x.getTipo());
            compromiso.setNumero(x.getNumero());
            compromiso.setFecha(x.getFecha());
            compromiso.setNumdoc(x.getNumdoc());
            compromiso.setFecdoc(x.getFecdoc());
            compromiso.setTotal(x.getTotal());
            compromiso.setSwmultiple(x.getSwmultiple());
            compromiso.setEstado(x.getEstado());
            compromiso.setDescripcion(x.getDescripcion());
            compromiso.setComprobante(x.getComprobante());

            compromiso.setBeneficiario(x.getBeneficiario());
            compromiso.setDocumento(x.getDocumento());
            compromiso.setContratacion(x.getContratacion());
            compromiso.setDepartamento(x.getDepartamento());

            compromiso.setUsumodi(x.getUsumodi());
            compromiso.setFecmodi(x.getFecmodi());

            return dao.save(compromiso);
        } else {
            throw new RuntimeException("Compromiso con id " + idcompromiso);
        }
    }

    // Elimina
    public void deleteById(Short idcompromiso) {
        dao.deleteById(idcompromiso);
    }

    // Actualiza compromiso.total sumando ejecucion.prmiso
    public BigDecimal actualizaTotalCompromiso(Short idcompromiso) {
        Compromisos compro = dao.findById(idcompromiso)
                .orElseThrow(() -> new EntityNotFoundException("Compromiso no encontrada con ID: " + idcompromiso));
        BigDecimal sumaPrmiso = daoejecu.sumarPrmisoPorIdcompromiso(idcompromiso);
        compro.setTotal(sumaPrmiso);
        dao.save(compro);
        return sumaPrmiso;
    }

}

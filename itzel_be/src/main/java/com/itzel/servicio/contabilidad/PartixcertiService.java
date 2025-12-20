package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Partixcerti;
import com.itzel.repositorio.contabilidad.EjecucionR;
import com.itzel.repositorio.contabilidad.PartixcertiR;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@Service
public class PartixcertiService {

    private final PartixcertiR dao;
    private final CertificacionService certiService;
    private final PresupuestoService presuService;
    private final EjecucionR daoejecu;

    // Partidas por Certificacion
    public List<Partixcerti> obtenerPorIdcertificacion(Short idcertificacion) {
        return dao.findByCertificacion_Idcertificacion(idcertificacion);
    }

    // Partixcerti con saldo a una fecha y desde/hasta
    public List<Partixcerti> obtenerPartidasConSaldo(LocalDate fechaHasta, int numDesde, int numHasta) {
        return dao.findByPartixcertiConSaldo(fechaHasta, numDesde, numHasta);
    }

    // Cuanta las partixcerti de un Partida
    public short contarPorIdpresupuesto(Short idpresupueto) {
        return dao.countByPresupuesto_Idpresupuesto(idpresupueto);
    }

    // Cuanta las partixcerti de una Certificación
    public short contarPorIdcertificacion(Short idcertificacion) {
        return dao.countByCertificacion_Idcertificacion(idcertificacion);
    }

    // Guarda nuevo. Actualiza certificaciones.total y presupuesto.totcerti
    @Transactional
    public Partixcerti creaPartixceriYActualizaTotal(Partixcerti parxcer) {
        Partixcerti newparxcer = dao.save(parxcer);
        Long idcertificacion = newparxcer.getCertificacion().getIdcertificacion();
        Short idpresupuesto = newparxcer.getPresupuesto().getIdpresupuesto();
       // certiService.actualizarTotalCertificacion(idcertificacion);
        presuService.actualizaTotcerti(idpresupuesto);
        return newparxcer;
    }

    // Actualiza partixcerti, certificaciones.total y presupuesto.totcerti
    @Transactional
    public Partixcerti actualizarPartidaYRecalcularTotal(Long idparxcer, Partixcerti x) {
        Partixcerti y = dao.findById(idparxcer)
                .orElseThrow(() -> new EntityNotFoundException("Partixcerti no encontrada: " + idparxcer));

        boolean valorCambio = x.getValor() != null &&
                y.getValor() != null &&
                x.getValor().compareTo(y.getValor()) != 0;

        y.setValor(x.getValor());
        y.setReintegro(x.getReintegro());
        y.setDescripcion(x.getDescripcion());
        y.setTotprmisos(x.getTotprmisos());
        y.setSaldo(x.getSaldo());
        y.setEjecucion(x.getEjecucion());
        y.setPresupuesto(x.getPresupuesto());
        y.setUsumodi(x.getUsumodi());
        y.setFecmodi(x.getFecmodi());
        Partixcerti guardada = dao.save(y);

        if (valorCambio) {
            Long idcertificacion = guardada.getCertificacion().getIdcertificacion();
            //certiService.actualizarTotalCertificacion(idcertificacion);
            Short idpresupuesto = guardada.getPresupuesto().getIdpresupuesto();
            presuService.actualizaTotcerti(idpresupuesto);
        }
        return guardada;
    }

    // Elimina. Actualiza certificaciones.total y presupuesto.totcerti
    @Transactional
    public void eliminaPartixcertiYActualizaTotal(Long idparxcer) {
        Partixcerti parxcer = dao.findById(idparxcer)
                .orElseThrow(() -> new EntityNotFoundException("Partida no encontrada con ID: " + idparxcer));
        Long idcertificacion = parxcer.getCertificacion().getIdcertificacion();
        Short idpresupuesto = parxcer.getPresupuesto().getIdpresupuesto();
        dao.delete(parxcer);
        //certiService.actualizarTotalCertificacion(idcertificacion);
        presuService.actualizaTotcerti(idpresupuesto);
    }

    // Actualiza partixcerti.totprmisos sumando ejecucion.prmiso
    public void actualizaTotprmisos(Long idparxcer) {
        Partixcerti parxcer = dao.findById(idparxcer)
                .orElseThrow(() -> new EntityNotFoundException("Partixcerti no encontrada con ID: " + idparxcer));
        BigDecimal sumaPrmiso = daoejecu.sumaPrmisoPorIdparxcer(idparxcer);
        parxcer.setTotprmisos(sumaPrmiso);
        dao.save(parxcer);
    }

    // Certificaciones de una Partida en un rango de fechas
    public List<Partixcerti> obtenerPartidasPorPresupuestoYFechas(Short idpresupuesto, LocalDate fechaDesde,
                                                                  LocalDate fechaHasta) {
        return dao.findByPresupuesto_IdpresupuestoAndCertificacion_FechaBetweenOrderByCertificacion_Fecha(idpresupuesto,
                fechaDesde, fechaHasta);
    }

}


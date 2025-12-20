package com.itzel.servicio.contabilidad;


import com.itzel.DTO.contabilidad.AuxingresoReporte;
import com.itzel.modelo.contabilidad.Ejecucion;
import com.itzel.repositorio.contabilidad.EjecucionR;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class EjecucionService {

    private final EjecucionR dao;
    private final CompromisoService comproService;
    private final PresupuestoService presuService;
    private final PartixcertiService parxcerService;

    // Cuenta las Partixcerti de una Ejecucion (compromismos de una partixcerti)
    public short contarPorIdparxcer(Long idparxcer) {
        return dao.countByPartixcerti_Idparxcer(idparxcer);
    }

    // Partixcerti de una Ejecucion (compromismos de una partixcerti)
    public List<Ejecucion> findPorIdparxcer(Long idparxcer) {
        return dao.findByPartixcerti_Idparxcer(idparxcer);
    }

    // Conteo por idpresupuesto
    public short contarPorIdpresupuesto(Short idpresupuesto) {
        return dao.countByPresupuesto_Idpresupuesto(idpresupuesto);
    }

    // Guarda nuevo (general para ejecucion de cuentas de ingresos).
    public <S extends Ejecucion> S save(S entity) {
        return dao.save(entity);
    }

    // Guarda ejecucion (compromiso).
    // Actualiza Compromisos.total, Presupuesto.totmisos y Partixcerti.totprmisos
    @Transactional
    public Ejecucion creaEjecucionCompromiso(Ejecucion ejecu) {
        Ejecucion newejecu = dao.save(ejecu);
        Short idcompromiso = newejecu.getCompromiso().getIdcompromiso();
        comproService.actualizaTotalCompromiso(idcompromiso);
        Short idpresupuesto = newejecu.getPresupuesto().getIdpresupuesto();
        presuService.actualizaTotmisos(idpresupuesto);
        Long idparxcer = Long.valueOf(newejecu.getPartixcerti().getIdparxcer());
        parxcerService.actualizaTotprmisos(idparxcer);
        return newejecu;
    }

    // Guarda ejecucion (devengado). Presupuesto.totdeven(NO se necesita)
    // Actualiza: Presupuesto.totdeven y Ejecucion.totdeven
    @Transactional
    public Ejecucion creaEjecucionDevengado(Ejecucion ejecu) {
        Ejecucion newejecu = dao.save(ejecu);
        Short idpresupuesto = newejecu.getPresupuesto().getIdpresupuesto();
        presuService.actualizaTotdeven(idpresupuesto);
        Long idcomprom = (long) newejecu.getCompromiso().getIdcompromiso();
        actualizaTotdeven(idcomprom);
        return newejecu;
    }

    // Actualiza Ejecucion.totdeven sumando Ejecucion.devengado (de la misma tabla)
    public void actualizaTotdeven(Long idcomprom) {
        Ejecucion ejecu = dao.findById(idcomprom)
                .orElseThrow(() -> new EntityNotFoundException("Ejecución no encontrada con ID: " + idcomprom));
        BigDecimal sumaDevengado = dao.sumaDevengadoPorIdcomprom(idcomprom);
        ejecu.setTotdeven(sumaDevengado);
        dao.save(ejecu);
    }

    // Partidas por Compromiso
    public List<Ejecucion> obtenerPorIdcompromiso(Short idcompromiso) {
        return dao.findByCompromiso_IdcompromisoOrderByPresupuestoProyectoCodigoAscPresupuestoCodparAsc(idcompromiso);
    }

    // Busca por idejecucion
    public Optional<Ejecucion> findById(Long idejecucion) {
        return dao.findById(idejecucion);
    }

    // Ejecución de una Partida (auxiliar presupuestario por idpresupuesto)
    public List<Ejecucion> obtenerPorIdpresupuestoYFechas(Short idpresupuesto, LocalDate desde, LocalDate hasta) {
        return dao.findByPresupuesto_IdpresupuestoAndFechaBetweenOrderByFechaAscIdejecucionAsc(idpresupuesto, desde,
                hasta);
    }

    // Ejecuciones de un Asiento
    public List<Ejecucion> obtenerPorIdasiento(Short idasiento) {
        return dao.findByIdasiento(idasiento);
    }

    // Ejecución de una Transaccion (es de 1 a 1 y opcional)
    public Optional<Ejecucion> buscarPorTransaccion(Long idtransaccion) {
        return dao.findByTransaccion(idtransaccion);
    }

    // Ejecuciones de un idcomprom (Devengados de un compromiso)
    public List<Ejecucion> obtenerPorIdcomprom(Long idcomprom) {
        return dao.findByCompromiso_Idcompromiso(idcomprom);
    }

    // Actualiza Ejecucion. Actualiza Compromisos.total, Presuspuesto.totmisos y
    // Partixcerti.totprmisos
    @Transactional
    public Ejecucion actualizaEjecucionCompromiso(Long idejecucion, Ejecucion x) {
        Ejecucion y = dao.findById(idejecucion)
                .orElseThrow(() -> new EntityNotFoundException("Ejecución no encontrada: " + idejecucion));
        boolean prmisoCambio = x.getPrmiso() != null &&
                y.getPrmiso() != null &&
                x.getPrmiso().compareTo(y.getPrmiso()) != 0;

        // y.setModifi(x.getModifi());
        y.setPrmiso(x.getPrmiso());
        // y.setDevengado(x.getDevengado());
        // y.setCobpagado(x.getCobpagado());
        y.setConcepto(x.getConcepto());
        y.setUsumodi(x.getUsumodi());
        y.setFecmodi(x.getFecmodi());
        Ejecucion guardada = dao.save(y);

        if (prmisoCambio) {
            Short idcompromiso = guardada.getCompromiso().getIdcompromiso();
            comproService.actualizaTotalCompromiso(idcompromiso);
            Short idpresupuesto = guardada.getPresupuesto().getIdpresupuesto();
            presuService.actualizaTotmisos(idpresupuesto);
            Long idpartixcerti = guardada.getPartixcerti().getIdparxcer();
            parxcerService.actualizaTotprmisos(idpartixcerti);
        }
        return guardada;
    }

    // Actualiza (la sociada a la transacción) y la ejecucion del compromiso
    // Actualiza Presuspuesto.totdeven y ejecucion.totdeven
    @Transactional
    public Ejecucion actualizaEjecucionDevengado(Long idejecucion, Ejecucion x) {
        // Recuperar el registro existente
        Ejecucion y = dao.findById(idejecucion)
                .orElseThrow(() -> new EntityNotFoundException("Ejecución no encontrada"));
        // Actualizar solo los campos requeridos
        y.setDevengado(x.getDevengado());
        y.setConcepto(x.getConcepto());
        y.setUsumodi(x.getUsumodi());
        y.setFecmodi(x.getFecmodi());
        Ejecucion actualizada = dao.save(y); // Persiste los cambios
        // Actualizar presupuesto siempre (depende del conjunto de ejecuciones)
        Short idPresupuesto = actualizada.getPresupuesto().getIdpresupuesto();
        presuService.actualizaTotdeven(idPresupuesto);
        // Actualizar totdeven de la ejecución del compromiso (misma tabla)
        Long idcomprom = (long) actualizada.getCompromiso().getIdcompromiso();
        actualizaTotdeven(idcomprom);
        return actualizada;
    }

    // Elimina ejecucion (sin actualizar nada)
    public Ejecucion deleteEjecucion(Long id) {
        Ejecucion ejecucion = dao.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("No existe Ejecución con id " + id));
        dao.delete(ejecucion);
        return ejecucion; // Devuelve el registro eliminado
    }

    // Elimina (compromiso)
    // Actualiza Compromisos.total, Presuspuesto.totmisos y Partixcerti.totprmisos
    @Transactional
    public void eliminaEjecucionCompromiso(Long idejecucion) {
        Ejecucion y = dao.findById(idejecucion)
                .orElseThrow(() -> new EntityNotFoundException("Ejecución no encontrada"));
        // Guarda las referencias antes de eliminar
        Short idcompromiso = y.getCompromiso().getIdcompromiso();
        Short idpresupuesto = y.getPresupuesto().getIdpresupuesto();
        Long idpartixcerti = Long.valueOf(y.getPartixcerti().getIdparxcer());
        dao.delete(y); // Elimina la ejecución (compromiso)
        comproService.actualizaTotalCompromiso(idcompromiso);
        presuService.actualizaTotmisos(idpresupuesto);
        parxcerService.actualizaTotprmisos(idpartixcerti);
    }

    // Elimina (la asociada a la transacción)
    // Actualiza Presuspuesto.totdeven y ejecucion.totdeven
    @Transactional
    public void eliminaEjecucionDevengado(Long idejecucion) {
        Ejecucion y = dao.findById(idejecucion)
                .orElseThrow(() -> new EntityNotFoundException("Ejecución no encontrada"));
        // Guarda las referencias antes de eliminar
        Short idpresupuesto = y.getPresupuesto().getIdpresupuesto();
        Long idcomprom = (long) y.getCompromiso().getIdcompromiso();
        dao.delete(y); // Elimina la ejecución asociada al compromiso
        presuService.actualizaTotdeven(idpresupuesto); // Actualiza los totales después de la eliminación
        actualizaTotdeven(idcomprom);
    }

    // === REPORTES ===
    // Auxiliar presupuestario de Ingreso
    public List<AuxingresoReporte> getAuxingreso(
            String codigoProyecto,
            String codpar,
            LocalDate desde,
            LocalDate hasta) {
        List<Ejecucion> entidades = dao.findEjecucionByProyectoAndCodparAndFecha(
                codigoProyecto,
                codpar,
                desde,
                hasta);
        return entidades.stream()
                .map(e -> new AuxingresoReporte(
                        e.getFecha() != null ? e.getFecha().toString() : null,
                        e.getIdasiento() != null ? e.getIdasiento().toString() : null,
                        e.getModifi(),
                        e.getPrmiso(),
                        e.getDevengado(),
                        e.getCobpagado(),
                        calcularSaldoDevengado(e),
                        calcularSaldoCobrado(e),
                        e.getConcepto()))
                .toList();
    }

    private BigDecimal calcularSaldoDevengado(Ejecucion e) {
        if (e.getPrmiso() == null || e.getDevengado() == null)
            return null;
        return e.getPrmiso().subtract(e.getDevengado());
    }

    private BigDecimal calcularSaldoCobrado(Ejecucion e) {
        if (e.getDevengado() == null || e.getCobpagado() == null)
            return null;
        return e.getDevengado().subtract(e.getCobpagado());
    }

}

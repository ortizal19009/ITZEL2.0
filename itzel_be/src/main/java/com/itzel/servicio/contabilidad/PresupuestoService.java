package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.repositorio.contabilidad.EjecucionR;
import com.itzel.repositorio.contabilidad.PartixcertiR;
import com.itzel.repositorio.contabilidad.PresupuestoR;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class PresupuestoService {

    private final PresupuestoR dao;
    private final PartixcertiR daoparxcer;
    private final EjecucionR daoejecu;

    // Busca por proyecto.codigo, tippar, codpar Y nompar
    public List<Presupuesto> buscarPartidasPorCampos(String codigo, short tippar, String codpar, String nompar) {
        return dao
                .findByProyecto_CodigoStartingWithAndTipparAndCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(
                        codigo, tippar, codpar, nompar);
    }

    // Valida codpar por proyecto
    public boolean valCodparPorProyecto(String codpar, Short idproyecto) {
        return dao.existsByCodparAndProyecto_Idproyecto(codpar, idproyecto);
    }

    // Valida nompar por proyecto
    public boolean valNomparPorProyecto(String nompar, Short idproyecto) {
        return dao.existsByNomparIgnoreCaseAndProyecto_Idproyecto(nompar, idproyecto);
    }

    // Cuenta por idclasificador
    public short cuentaPartidasPorClasificador(short idclasificador) {
        return dao.countByClasificador_Idclasificador(idclasificador);
    }

    // Cuenta por idproyecto
    public short cuentaPorProyecto(short idproyecto) {
        return dao.countByProyecto_Idproyecto(idproyecto);
    }

    // Partidas para datalist
    public List<Presupuesto> obtenerPresupuestosPorTipoyCodigo(Short tippar, String codpar) {
        return dao.findByTipparAndCodparStartingWithOrderByCodparAscProyecto_CodigoAsc(tippar, codpar);
    }

    // Partidas para ng-select
    public List<Presupuesto> obtenerPresupuestoPorTipo(Short tippar) {
        return dao.findByTipparOrderByCodparAscProyecto_CodigoAsc(tippar);
    }

    // Busca por idproyecto y codpar
    public Optional<Presupuesto> buscarPorProyectoYCodpar(Short idproyecto, String codpar) {
        return dao.findByProyecto_IdproyectoAndCodpar(idproyecto, codpar);
    }

    // Verifica existencia por codpar
    public boolean existePorCodpar(String codpar) {
        return dao.existsByCodpar(codpar);
    }

    // Guarda nuevo
    public <S extends Presupuesto> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por idpresupuesto
    public Optional<Presupuesto> findById(short idpresupuesto) {
        return dao.findById(idpresupuesto);
    }

    // Actualizar
    public Presupuesto actualiza(Short idpresupuesto, Presupuesto x) {
        Optional<Presupuesto> y = dao.findById(idpresupuesto);
        if (y.isPresent()) {
            Presupuesto partida = y.get();
            partida.setTippar(x.getTippar());
            partida.setCodpar(x.getCodpar());
            partida.setCodigo(x.getCodigo());
            partida.setNompar(x.getNompar());
            partida.setInicial(x.getInicial());
            partida.setTotmod(x.getTotmod());
            partida.setTotcerti(x.getTotcerti());
            partida.setTotdeven(x.getTotdeven());
            partida.setTotmisos(x.getTotmisos());
            partida.setArrastre(x.getArrastre());
            partida.setArrastreaa(x.getArrastreaa());

            partida.setUsumodi(x.getUsumodi());
            partida.setFecmodi(x.getFecmodi());

            partida.setProyecto(x.getProyecto());
            partida.setClasificador(x.getClasificador());

            return dao.save(partida);
        } else {
            throw new RuntimeException("Partida no encontrada con id " + idpresupuesto);
        }
    }

    // Eliminar
    public void deleteById(Short idpresupuesto) {
        dao.deleteById(idpresupuesto);
    }

    // Actualiza presupuesto.totcerti sumando partixcerti.valor
    public void actualizaTotcerti(Short idpresupuesto) {
        Presupuesto presu = dao.findById(idpresupuesto)
                .orElseThrow(() -> new EntityNotFoundException("Partida no encontrada con ID: " + idpresupuesto));
        BigDecimal totalCerti = daoparxcer.sumaValorPorPartida(idpresupuesto);
        presu.setTotcerti(totalCerti);
        dao.save(presu);
    }

    // Actualiza presupuesto.totmisos sumando ejecucio.prmiso (se necesita ??)
    public void actualizaTotmisos(Short idpresupuesto) {
        Presupuesto presu = dao.findById(idpresupuesto)
                .orElseThrow(() -> new EntityNotFoundException("Partida no encontrada con ID: " + idpresupuesto));
        BigDecimal totalPrmisos = daoejecu.sumaPrmisoPorPartida(idpresupuesto);
        presu.setTotmisos(totalPrmisos);
        dao.save(presu);
    }

    // Actualiza presupuesto.totdeven sumando ejecucio.devengado
    public void actualizaTotdeven(Short idpresupuesto) {
        Presupuesto presu = dao.findById(idpresupuesto)
                .orElseThrow(() -> new EntityNotFoundException("Partida no encontrada con ID: " + idpresupuesto));
        BigDecimal totalDevengado = daoejecu.sumaDevengadoPorPartida(idpresupuesto);
        presu.setTotdeven(totalDevengado);
        dao.save(presu);
    }

}

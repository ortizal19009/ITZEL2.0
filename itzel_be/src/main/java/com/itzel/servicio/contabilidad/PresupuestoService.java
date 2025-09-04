package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.repositorio.contabilidad.PresupuestoR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PresupuestoService {
    @Autowired
    private PresupuestoR dao;
    public Page<Presupuesto> findAllByPage(int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return dao.findAll(pageable);
    }

    public Page<Presupuesto> findByTipparPageable(int tippar, int page, int size){
        Pageable pageable= PageRequest.of(page, size);
        return dao.findByTipparPageable(tippar, pageable);

    }
    public Page<Presupuesto> findByParDenom(String dato,int tippar, int page, int size){
        Pageable pageable= PageRequest.of(page, size);
        return dao.findByParDenom(dato, tippar, pageable);

    }
    public Presupuesto findByCodPar(String codpar){
        return dao.findByCodpar(codpar);
    }
    public Optional<Presupuesto> findById(Short idpresupuesto){
        return dao.findById(idpresupuesto);
    }
    public List<Presupuesto>findByCodigoProyectoLike(String codigo){
        return dao.findByCodigoProyectoLike(codigo);
    }
    public List<Presupuesto> findTipparAndCodpar(int tippar , String codpar){
        return dao.findByTipparAndCodparContainingOrderByCodpar(tippar, codpar);
    }


    // Busca por tippar, codpar Y nompar
    public List<Presupuesto> buscarPartidasPorCampos(short tippar, String codpar, String nompar) {
        return dao.findByTipparAndCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(tippar, codpar, nompar);
    }

    // Valida codpar
    public boolean valCodpar(String codpar) {
        return dao.existsByCodpar(codpar);
    }

    // Validar nompar
    public boolean valNompar(String nompar) {
        return dao.existsByNomparIgnoreCase(nompar);
    }

    // Cuenta las partidas del clasificador por idclasificador
    public short cuentaPartidasPorClasificador(short idclasificador) {
        return dao.countByClasificador_Idclasificador(idclasificador);
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
}

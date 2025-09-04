package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import com.itzel.repositorio.contabilidad.ClasificadorR;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@RequiredArgsConstructor
@Service
public class ClasificadorService {
    @Autowired
    private ClasificadorR dao;
    public List<Clasificador> findAll(){
        return dao.findAll();
    }
    public List<Clasificador> findByCodOrNom(String dato){
        return dao.findByCodOrNom(dato);
    }


    // Busca por codpar y nompar ordenado por codpar
    public List<Clasificador> buscarPorCodparYNompar(String codpar, String nompar) {
        return dao.findByCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(codpar, nompar);
    }

    // Valida codpar
    public boolean valCodpar(String codpar) {
        return dao.existsByCodpar(codpar);
    }

    // Validar nompar
    public boolean valNompar(String nompar) {
        return dao.existsByNomparIgnoreCase(nompar);
    }

    // Partidas de ingresos del clasificador para datalist
    public List<Clasificador> obtenerPartidasing(String codpar) {
        return dao.findPartidasing(codpar+'%');
    }

    // Guarda nuevo
    public <S extends Clasificador> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por idclasificador
    public Optional<Clasificador> findById(Short idclasificador) {
        return dao.findById(idclasificador);
    }

    // Actualizar
    public Clasificador actualiza(Short idclasificador, Clasificador x) {
        Optional<Clasificador> y = dao.findById(idclasificador);
        if (y.isPresent()) {
            Clasificador partida = y.get();
            partida.setCodpar(x.getCodpar());
            partida.setNompar(x.getNompar());
            partida.setNivpar(x.getNivpar());
            partida.setGrupar(x.getGrupar());
            partida.setDespar(x.getDespar());
            partida.setCueejepresu(x.getCueejepresu());
            partida.setPresupuesto(x.getPresupuesto());
            partida.setEjecucion(x.getEjecucion());
            partida.setDevengado(x.getDevengado());
            partida.setReforma(x.getReforma());
            partida.setAsignaini(x.getAsignaini());
            partida.setGrupo(x.getGrupo());
            partida.setBalancostos(x.getBalancostos());

            partida.setUsumodi(x.getUsumodi());
            partida.setFecmodi(x.getFecmodi());

            return dao.save(partida);
        } else {
            throw new RuntimeException("Partida del clasificador no encontrada con id " + idclasificador);
        }
    }

    // Eliminar
    public void deleteById(Short idclasificador) {
        dao.deleteById(idclasificador);
    }

}

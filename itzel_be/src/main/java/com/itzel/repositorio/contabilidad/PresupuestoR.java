package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PresupuestoR extends JpaRepository<Presupuesto, Short> {

    // Busca por tippar y codpar o nompar ordenado por codpar
    List<Presupuesto> findByTipparAndCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(short tippar,
                                                                                                     String codpar,
                                                                                                     String nompar);

    // Busca por proyecto.codigo, tippar, codpar o nompar ordenado por codpar
    List<Presupuesto> findByProyecto_CodigoStartingWithAndTipparAndCodparStartingWithAndNomparContainingIgnoreCaseOrderByCodparAsc(
            String codigo, short tippar, String codpar, String nompar);

    // Busca todas por tippar (para usar en ng-select)
    List<Presupuesto> findByTipparOrderByCodparAscProyecto_CodigoAsc(short tippar);

    // Valida codpar por proyecto
    boolean existsByCodparAndProyecto_Idproyecto(String codpar, Short idproyecto);

    // Valida nompar por proyecto
    boolean existsByNomparIgnoreCaseAndProyecto_Idproyecto(String nompar, Short idproyecto);

    // Conteo por idclasificador
    short countByClasificador_Idclasificador(short idclasificador);

    // Conteo por idproyecto
    short countByProyecto_Idproyecto(short idproyecto);

    // Partidas para datalist
    List<Presupuesto> findByTipparAndCodparStartingWithOrderByCodparAscProyecto_CodigoAsc(Short tippar,
                                                                                          String codpar);

    // Presupuesto findByCodpar(String codpar);
    // Optional<Presupuesto> findByCodpar(String codpar);

    // Busca por proyecto y codpar
    Optional<Presupuesto> findByProyecto_IdproyectoAndCodpar(short idproyecto, String codpar);

    // Existe codpar
    boolean existsByCodpar(String codpar);

}

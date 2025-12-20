package com.itzel.repositorio.contabilidad;


import com.itzel.modelo.contabilidad.Compromisos;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface CompromisosR extends JpaRepository<Compromisos, Short> {

    List<Compromisos> findByNumeroBetweenAndFechaBetweenAndTipoOrderByNumero(long desdeNum, long hastaNum,
                                                                             LocalDate desdeFecha, LocalDate hastaFecha, short tipo);

    // Valida numero
    boolean existsByTipoAndNumero(short tipo, long numero);

    // Ultimo compromiso por numero
    Compromisos findFirstByTipoOrderByNumeroDesc(short tipo);

    // Siguiente numero
//    Compromisos findTopByTipoOrderByNumeroDesc(short tipo);

    // Conteo por idcontratacion
    short countByContratacion_Idcontratacion(Short idcontratacion);

    // Cuenta cuantos Compromisos tiene un iddocumento
    short countByDocumento_Iddocumento(Short iddocumento);

    // Busca por número
    Optional<Compromisos> findByTipoAndNumero(short tipo, long numero);

}

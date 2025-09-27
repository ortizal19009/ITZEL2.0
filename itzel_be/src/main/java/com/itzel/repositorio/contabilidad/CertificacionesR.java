package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface CertificacionesR extends JpaRepository<Certificaciones , Long> {
    //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
    List<Certificaciones> findFirstByTipoOrderByNumeroAsc(short tipo);
    Certificaciones findFirstByTipoOrderByNumeroDesc(short tipo);
    List<Certificaciones> findByTipoAndFechaBetweenOrderByNumeroDesc(int tipo, LocalDate start, LocalDate end);
    List<Certificaciones> findByTipoAndNumeroBetweenOrderByNumeroDesc(int tipo, int min, int max);
    List<Certificaciones> findByTipoAndFechaBetweenAndNumeroBetweenOrderByNumeroAsc(int tipo, LocalDate start, LocalDate end, int min, int max);
}

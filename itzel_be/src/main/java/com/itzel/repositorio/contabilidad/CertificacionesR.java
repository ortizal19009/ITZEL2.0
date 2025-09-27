package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface CertificacionesR extends JpaRepository<Certificaciones , Long> {
    //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
    List<Certificaciones> findFirstByTipoOrderByNumeroAsc(short tipo);
    //Buscar el ultimo registro guardado por el tipo (certificacion/reintegro)
    Certificaciones findFirstByTipoOrderByNumeroDesc(short tipo);
    //Buscar el regristro por rango fecha y tipo
    List<Certificaciones> findByTipoAndFechaBetweenOrderByNumeroDesc(int tipo, LocalDate start, LocalDate end);
    //Buscar el registro por rango de numero y pipo
    List<Certificaciones> findByTipoAndNumeroBetweenOrderByNumeroDesc(int tipo, int min, int max);
    //Buscar la certificacion por el tipo, entre la fecha y entre el numero
    List<Certificaciones> findByTipoAndFechaBetweenAndNumeroBetweenOrderByNumeroAsc(int tipo, LocalDate start, LocalDate end, int min, int max);
    //Buscar la certificacion por numero y tipo, para validar si ya existe o no
    Certificaciones findByTipoAndNumero(int tipo, int numero);
}

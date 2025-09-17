package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CertificacionesR extends JpaRepository<Certificaciones , Long> {
    List<Certificaciones> findFirstByTipoOrderByNumeroAsc(short tipo);
}

package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import com.itzel.repositorio.contabilidad.CertificacionesR;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CertificacionService {
    @Autowired
    private CertificacionesR certificacionesR;
    //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
    public List<Certificaciones> findFirstByTipoOrderByNumeroAsc(short tipo) {
        return certificacionesR.findFirstByTipoOrderByNumeroAsc(tipo);
    }

    public Certificaciones save(Certificaciones c) {
        return certificacionesR.save(c);
    }

    public void deleteByIdCertificacion(Long idcertificacion) {
        if (!certificacionesR.existsById(idcertificacion)) {
            throw new EntityNotFoundException("Certificación con id " + idcertificacion + " no encontrada");
        }
        certificacionesR.deleteById(idcertificacion);
    }
}
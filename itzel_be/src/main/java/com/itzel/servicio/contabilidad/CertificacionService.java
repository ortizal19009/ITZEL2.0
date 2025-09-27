package com.itzel.servicio.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import com.itzel.repositorio.contabilidad.CertificacionesR;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;

@Service
public class CertificacionService {
    @Autowired
    private CertificacionesR certificacionesR;
    //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
    public List<Certificaciones> findFirstByTipoOrderByNumeroAsc(short tipo) {
        return certificacionesR.findFirstByTipoOrderByNumeroAsc(tipo);
    }

    public Certificaciones findLastByTipo(short tipo){
        return certificacionesR.findFirstByTipoOrderByNumeroDesc(tipo);
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
    public List<Certificaciones> getByNumDate(short tipo, LocalDate fechaInicio, LocalDate fechaFin, short min, short max) {
        Set<Certificaciones> result = new HashSet<>();
        result.addAll(certificacionesR.findByTipoAndFechaBetweenOrderByNumeroDesc(tipo, fechaInicio, fechaFin));
        result.addAll(certificacionesR.findByTipoAndNumeroBetweenOrderByNumeroDesc(tipo, min, max));

        // Convertir a lista y ordenar
        return result.stream()
                .sorted(Comparator.comparing(Certificaciones::getNumero).reversed())
                .toList();
    }

    public List<Certificaciones> findByTipoAndNumeroBetweenAndFechaBetweenOrderByNumeroAsc(int tipo, LocalDate start, LocalDate end, int min, int max){
        return  certificacionesR.findByTipoAndFechaBetweenAndNumeroBetweenOrderByNumeroAsc(tipo, start, end, min, max);
    }

    public Optional<Certificaciones> findById(Long idcertificacion){
        return certificacionesR.findById(idcertificacion);
    }
    public Certificaciones findByTipoAndNumero(int tipo, int numero){
        return certificacionesR.findByTipoAndNumero(tipo, numero);
    }
}
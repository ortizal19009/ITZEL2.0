package com.itzel.servicio.contabilidad;

import com.itzel.repositorio.contabilidad.CertificacionesR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CertificacionService {
    @Autowired
    private CertificacionesR certificacionesR;
}

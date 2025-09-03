package com.itzel.controlador.contabilidad;

import com.itzel.servicio.contabilidad.CertificacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/certificaciones")
@CrossOrigin("*")
public class CertificacionesApi {
    @Autowired
    private CertificacionService certificacionService;
}

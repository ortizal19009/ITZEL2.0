package com.amon_ra.controlador.contabilidad;

import com.amon_ra.modelo.contabilidad.Estructura;
import com.amon_ra.servicio.contabilidad.EstructuraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/estructura")
@CrossOrigin("*")
public class EstructuraApi {
    private final EstructuraService estructuraService;

    public EstructuraApi(EstructuraService estructuraService) {
        this.estructuraService = estructuraService;
    }

    @GetMapping
    public ResponseEntity<List<Estructura>> getAll(){
        List<Estructura> estructuras = estructuraService.findAll();
        if (estructuras != null){
            return ResponseEntity.ok(estructuras);
        }
        return ResponseEntity.noContent().build();
    }
}

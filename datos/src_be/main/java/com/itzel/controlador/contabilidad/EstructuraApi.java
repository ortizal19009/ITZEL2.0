package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Estructura;
import com.itzel.servicio.contabilidad.EstructuraService;
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
    @Autowired
    private EstructuraService estructuraService;
    @GetMapping
    public ResponseEntity<List<Estructura>> getAll(){
        List<Estructura> estructuras = estructuraService.findAll();
        if (estructuras != null){
            return ResponseEntity.ok(estructuras);
        }
        return ResponseEntity.noContent().build();
    }
}

package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Niveles;
import com.itzel.servicio.contabilidad.NivelesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/niveles")
public class NivelesApi {
    @Autowired
    private NivelesService nivelesService;

    @GetMapping
    public ResponseEntity<List<Niveles>> getAll(){
        return ResponseEntity.ok(nivelesService.findAll());
    }
}

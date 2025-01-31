package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import com.itzel.servicio.contabilidad.ClasificadorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/clasificador")
@CrossOrigin("*")
public class ClasificadorApi {
    @Autowired
    private ClasificadorService clasificadorService;
    @GetMapping
    public ResponseEntity<List<Clasificador>> getAll(){
        return ResponseEntity.ok(clasificadorService.findAll());
    }
}

package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Clasificador;
import com.itzel.servicio.contabilidad.ClasificadorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
    @GetMapping("/codnompar")
    public ResponseEntity<List<Clasificador>> findByCodOrNom(@RequestParam String dato){
        return ResponseEntity.ok(clasificadorService.findByCodOrNom(dato));
    }
}

package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Estructura;
import com.itzel.servicio.contabilidad.EstructuraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    // Devuelve la entidad con el nivel más alto
    @GetMapping("/maxnivel")
    public ResponseEntity<Estructura >findTopByOrderByNivelDesc(){
        return ResponseEntity.ok( estructuraService.findTopByOrderByNivelDesc());
    }
    // Devuelve todas las entidades con un nivel específico
    @GetMapping("/findByNivel")
    public ResponseEntity<List<Estructura>> findByNivel(@RequestParam Integer nivel){
        return ResponseEntity.ok( estructuraService.findByNivel(nivel));
    }
}

package com.itzel.controlador.contabilidad;


import com.itzel.modelo.contabilidad.Contratacion;
import com.itzel.servicio.contabilidad.ContratacionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/contratacion")
@CrossOrigin("*")

public class ContratacionApi {

    private final ContratacionService contraService;

    // Obtiene todos los Tipos de Contratacion ordenados por nombre
    @GetMapping()
    public ResponseEntity<List<Contratacion>> todos() {
        List<Contratacion> lista = contraService.obtenerPorNombre();
        return ResponseEntity.ok(lista);
    }

    // Valida si existe un nombre (ignorando mayúsculas y minúsculas)
    @GetMapping("/valnombre/{nombre}")
    public ResponseEntity<Boolean> existeNombre(@PathVariable String nombre) {
        boolean existe = contraService.existeNombre(nombre);
        return ResponseEntity.ok(existe);
    }

    // Guardar nuevo
    @PostMapping
    public Contratacion save(@RequestBody Contratacion contra) {
        return contraService.save(contra);
    }

    // Busca por id
    @GetMapping("/{idcontratacion}")
    public ResponseEntity<Contratacion> getByidcontratacion(@PathVariable Short idcontratacion) {
        Contratacion contra = contraService.findById(idcontratacion)
                .orElseThrow();
        return ResponseEntity.ok(contra);
    }

    // Actualiza
    @PutMapping("/{idcontratacion}")
    public Contratacion actualizarContratacion(@PathVariable Short idcontratacion, @RequestBody Contratacion x) {
        return contraService.actualizarContratacion(idcontratacion, x);
    }

    // Elimina
    @DeleteMapping("/{idcontratacion}")
    public ResponseEntity<Void> delete(@PathVariable("idcontratacion") Short idcontratacion) {
        contraService.deleteById(idcontratacion);
        return ResponseEntity.noContent().build();
    }

}

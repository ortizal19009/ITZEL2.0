package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Destinos;
import com.itzel.servicio.existencias.DestinoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/destinos")
@CrossOrigin("*")

public class DestinosApi {

    private final DestinoService destService;

    // Obtiene todas las Destinos ordenadas por nomdestino
    @GetMapping()
    public ResponseEntity<List<Destinos>> obtenerDestinossOrdenadosPorNomdestino() {
        List<Destinos> lista = destService.obtenerDestinosOrdenadasPorNomdestino();
        return ResponseEntity.ok(lista);
    }

    // Valida si existe un nomdestino (ignorando mayúsculas y minúsculas)
    @GetMapping("/valnomdestino/{nomdestino}")
    public ResponseEntity<Boolean> existeNomdestino(@PathVariable String nomdestino) {
        boolean existe = destService.existeNomdestino(nomdestino);
        return ResponseEntity.ok(existe);
    }

    // Guardar nuevo
    @PostMapping
    public Destinos save(@RequestBody Destinos dest) {
        return destService.save(dest);
    }

    // Busca por id
    @GetMapping("/{iddestino}")
    public ResponseEntity<Destinos> getByiddestino(@PathVariable Short iddestino) {
        Destinos dest = destService.findById(iddestino)
                .orElseThrow();
        return ResponseEntity.ok(dest);
    }

    // Actualiza
    @PutMapping("/{iddestino}")
    public Destinos actualizar(@PathVariable Short iddestino, @RequestBody Destinos x) {
        return destService.actualizar(iddestino, x);
    }

    // Elimina
    @DeleteMapping("/{iddestino}")
    public ResponseEntity<Void> delete(@PathVariable("iddestino") Short iddestino) {
        destService.deleteById(iddestino);
        return ResponseEntity.noContent().build();
    }

}

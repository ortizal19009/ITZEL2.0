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
    private ClasificadorService clasiService;
    @GetMapping
    public ResponseEntity<List<Clasificador>> getAll(){
        return ResponseEntity.ok(clasiService.findAll());
    }
    @GetMapping("/codnompar")
    public ResponseEntity<List<Clasificador>> findByCodOrNom(@RequestParam String dato){
        return ResponseEntity.ok(clasiService.findByCodOrNom(dato));
    }

    // Busca por tippar, codpar Y nompar
    @GetMapping("/busca")
    public ResponseEntity<List<Clasificador>> buscarPartidas(@RequestParam String codpar, @RequestParam String nompar) {
        List<Clasificador> resultados = clasiService.buscarPorCodparYNompar(codpar, nompar);
        return ResponseEntity.ok(resultados);
    }

    // Valida códpar
    @GetMapping("/valcodpar/{codpar}")
    public ResponseEntity<Boolean> validarCodpar(@PathVariable String codpar) {
        boolean existe = clasiService.valCodpar(codpar);
        return ResponseEntity.ok(existe);
    }

    // Valida nompar
    @GetMapping("/valnompar/{nompar}")
    public ResponseEntity<Boolean> valNompar(@PathVariable String nompar) {
        boolean existe = clasiService.valNompar(nompar);
        return ResponseEntity.ok(existe);
    }

    @GetMapping("/partidasing")
    public ResponseEntity<List<Clasificador>> getPartidasing(@RequestParam String codpar) {
        List<Clasificador> partidas = clasiService.obtenerPartidasing(codpar);
        return ResponseEntity.ok(partidas);
    }

    // Guarda nuevo
    @PostMapping
    public Clasificador save(@RequestBody Clasificador partida) {
        return clasiService.save(partida);
    }

    // Busca por idclasificador
    @GetMapping("/{idclasificador}")
    public ResponseEntity<Clasificador> getByIdclasificador(@PathVariable Short idclasificador) {
        Clasificador partida = clasiService.findById(idclasificador)
                .orElseThrow();
        return ResponseEntity.ok(partida);
    }

    // Actualiza
    @PutMapping("/{idclasificador}")
    public Clasificador actualizar(@PathVariable Short idclasificador, @RequestBody Clasificador x) {
        return clasiService.actualiza(idclasificador, x);
    }

    // Elimina
    @DeleteMapping("/{idclasificador}")
    public ResponseEntity<Void> delete(@PathVariable("idclasificador") Short idclasificador) {
        clasiService.deleteById(idclasificador);
        return ResponseEntity.noContent().build();
    }
}

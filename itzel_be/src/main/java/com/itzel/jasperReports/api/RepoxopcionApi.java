package com.itzel.jasperReports.api;

import com.itzel.jasperReports.modelo.Repoxopcion;
import com.itzel.jasperReports.services.RepoxopcionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/repoxopcion")
public class RepoxopcionApi {

    private final RepoxopcionService repoxopService;

    // Busca Repoxopcion
    @GetMapping("/busca")
    public ResponseEntity<List<Repoxopcion>> buscaRepoxopcion(@RequestParam String codigo,
                                                              @RequestParam String opcion,
                                                              @RequestParam String nombre) {
        List<Repoxopcion> lista = repoxopService.buscaRepoxopcion(codigo, opcion, nombre);
        return ResponseEntity.ok(lista);
    }

    // Repoxopcion para datalist
    @GetMapping("/datalist")
    public ResponseEntity<List<Repoxopcion>> datalistRepoxopcion(@RequestParam String codigo) {
        List<Repoxopcion> repoxopcion = repoxopService.datalistRepoxopcion(codigo);
        return ResponseEntity.ok(repoxopcion);
    }

    // Repoxopcion por Código y Largo
    @GetMapping("/codigo")
    public ResponseEntity<List<Repoxopcion>> obtenerPorPrefijoYLargo(@RequestParam String codigo) {
        List<Repoxopcion> repoxopcion = repoxopService.obtenerPorPrefijoYLargo(codigo);
        return ResponseEntity.ok(repoxopcion);
    }

    // Valida si existe un codigo (numerico)
    @GetMapping("/valcodigo/{codigo}")
    public ResponseEntity<Boolean> existeCodigo(@PathVariable String codigo) {
        boolean existe = repoxopService.valCodigo(codigo);
        return ResponseEntity.ok(existe);
    }

    // Valida si existe un nombre (ignorando mayúsculas y minúsculas)
    @GetMapping("/valnombre/{nombre}")
    public ResponseEntity<Boolean> existeNombre(@PathVariable String nombre) {
        boolean existe = repoxopService.valNombre(nombre);
        return ResponseEntity.ok(existe);
    }

    // Guardar nuevo
    @PostMapping
    public ResponseEntity<Repoxopcion> save(@RequestBody Repoxopcion x) {
        return ResponseEntity.ok(repoxopService.save(x));
    }

    // Actualiza
    @PutMapping("/{idrepoxopcion}")
    public Repoxopcion actualizar(@PathVariable Short idrepoxopcion, @RequestBody Repoxopcion x) {
        return repoxopService.actualizar(idrepoxopcion, x);
    }

    // Elimina
    @DeleteMapping("/{idrepoxopcion}")
    public ResponseEntity<Void> delete(@PathVariable("idrepoxopcion") Short idrepoxopcion) {
        repoxopService.deleteById(idrepoxopcion);
        return ResponseEntity.noContent().build();
    }

}


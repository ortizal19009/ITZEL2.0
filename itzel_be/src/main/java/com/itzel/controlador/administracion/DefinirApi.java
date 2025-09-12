package com.itzel.controlador.administracion;

import com.itzel.modelo.administracion.Definir;
import com.itzel.servicio.administracion.DefinirService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/definir")
@CrossOrigin("*")
public class DefinirApi {
    @Autowired
    private DefinirService defService;

    @GetMapping("/{iddefinir}")
    public ResponseEntity<Definir> getByIddefinir(@PathVariable Long iddefinir) {
        Definir definir = defService.findById(iddefinir).orElse(null);
        return definir != null ? ResponseEntity.ok(definir) : ResponseEntity.noContent().build();
    }

    // Actualizar
    @PutMapping("/{iddefinir}")
    public Definir actualizarDefinir(@PathVariable Long iddefinir, @RequestBody Definir x) {
        return defService.actualizarDefinir(iddefinir, x);
    }

}

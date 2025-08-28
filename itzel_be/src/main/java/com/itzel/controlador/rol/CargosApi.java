package com.itzel.controlador.rol;

import com.itzel.modelo.rol.Cargos;
import com.itzel.servicio.rol.CargoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cargos")
@CrossOrigin("*")
public class CargosApi {

    private final CargoService cargoService;

    public CargosApi(CargoService cargoService) {
        this.cargoService = cargoService;
    }

    // Obtiene todos los Cargos ordenados por nomcargo
    @GetMapping()
    public ResponseEntity<List<Cargos>> obtenerCargosOrdenadosPorNomcargo() {
        List<Cargos> lista = cargoService.obtenerCargosOrdenadosPorNomcargo();
        return ResponseEntity.ok(lista);
    }

    // Valida si existe un nomcargo (ignorando mayúsculas y minúsculas)
    @GetMapping("/valnomcargo/{nomcargo}")
    public ResponseEntity<Boolean> existeNomcargo(@PathVariable String nomcargo) {
        boolean existe = cargoService.existeNomcargo(nomcargo);
        return ResponseEntity.ok(existe);
    }

    // Guardar nuevo
    @PostMapping
    public Cargos save(@RequestBody Cargos cargos) {
        return cargoService.save(cargos);
    }

    // Busca por id
    @GetMapping("/{idcargo}")
    public ResponseEntity<Cargos> getByidcargo(@PathVariable Short idcargo) {
        Cargos cargos = cargoService.findById(idcargo)
                .orElseThrow();
        return ResponseEntity.ok(cargos);
    }

    // Actualiza
    @PutMapping("/{idcargo}")
    public Cargos actualizar(@PathVariable Short idcargo, @RequestBody Cargos x) {
        return cargoService.actualizar(idcargo, x);
    }

    // Elimina
    @DeleteMapping("/{idcargo}")
    public ResponseEntity<Void> delete(@PathVariable("idcargo") Short idcargo) {
        cargoService.deleteById(idcargo);
        return ResponseEntity.noContent().build();
    }

}
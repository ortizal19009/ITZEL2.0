package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Movimientos;
import com.itzel.servicio.existencias.MovimientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping
@CrossOrigin("/*")
public class MovimientoApi {
    private final MovimientoService movimientoService;

    //Guardar nuevo movimiento
    @PostMapping
    public ResponseEntity<Movimientos> saveMovimiento(@RequestBody Movimientos m){
        return ResponseEntity.ok(movimientoService.save(m));
    }
    //Encontrar los movimientos por tipo de movimiento (ingreso ó salida)
    @GetMapping("/tipmov")
    public ResponseEntity<List<Movimientos>> findByTipmov(@RequestParam Short tipmov){
        return ResponseEntity.ok(movimientoService.findByTipmov(tipmov));
    }
}

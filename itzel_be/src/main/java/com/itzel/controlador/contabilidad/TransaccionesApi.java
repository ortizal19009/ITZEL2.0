package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Transacciones;
import com.itzel.servicio.contabilidad.TransaccionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/transacciones")
@CrossOrigin("*")
public class TransaccionesApi {

    private final TransaccionService tranService;

    // Transacciones por Asiento
    @GetMapping("/busca/{idasiento}")
    public List<Transacciones> obtenerPorIdAsiento(@PathVariable Short idasiento) {
        return tranService.obtenerPorIdAsiento(idasiento);
    }

    // Guarda nuevo
    @PostMapping
    public Transacciones save(@RequestBody Transacciones transaccion) {
        return tranService.save(transaccion);
    }

    // Buscar por idtransaccion, cuando no existe retorna 404 (Not found)
    @GetMapping("/{idtransaccion}")
    public ResponseEntity<Transacciones> getByidtransaccion(@PathVariable Long idtransaccion) {
        return tranService.findById(idtransaccion)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Actualiza
    @PutMapping("/{idtransaccion}")
    public Transacciones actualiza(@PathVariable Long idtransaccion, @RequestBody Transacciones x) {
        return tranService.actualiza(idtransaccion, x);
    }

}

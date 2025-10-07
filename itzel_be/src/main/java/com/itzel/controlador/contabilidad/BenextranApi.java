package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Benextran;
import com.itzel.servicio.contabilidad.BenextranService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/benextran")
@CrossOrigin("*")
public class BenextranApi {

    private final BenextranService benxtraService;

    // Recupera por Transaccion
    @GetMapping("/transaccion/{idTransaccion}")
    public ResponseEntity<List<Benextran>> obtenerPorTransaccion(@PathVariable Long idtransaccion) {
        List<Benextran> registros = benxtraService.obtenerPorTransaccion(idtransaccion);
        if (registros.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(registros);
    }

    // Guarda nuevo
    @PostMapping
    public Benextran save(@RequestBody Benextran benextran) {
        return benxtraService.save(benextran);
    }

}

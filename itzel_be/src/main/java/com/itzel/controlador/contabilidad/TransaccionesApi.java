package com.itzel.controlador.contabilidad;

import com.itzel.DTO.SaveTxResponse;
import com.itzel.modelo.contabilidad.Transacciones;
import com.itzel.servicio.contabilidad.TransaccionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // OPCION DE GUARDADO CONTROLANDO LOS ASIENTOS
    @PostMapping("/save")
    public ResponseEntity<Map<String, Object>> saveControlado(){
        Transacciones transacciones = tranService.findById(8L).orElseThrow(()-> new RuntimeException("No encontrada"));

        Map<String , Object> response = new HashMap<>();
        //response.put("Consulta", transacciones);
        response.put("body",tranService.guardarTransaccion(transacciones));
        //tranService.saveTransaccion(transacciones);
        return ResponseEntity.ok( response);
    }
    // Guarda nuevo
    @PostMapping
    public ResponseEntity<Map<String, Object>> save(@RequestBody Transacciones transaccion) {
        Map<String , Object> response = new HashMap<>();
        response.put("status", HttpStatus.valueOf(200));
        response.put("body",tranService.guardarTransaccion(transaccion));
        return ResponseEntity.ok(response);
    }
    @DeleteMapping("/{idtransaccion}")
    public ResponseEntity<SaveTxResponse> deleteTransaccion(@RequestParam Long idtransaccion){
        return ResponseEntity.ok(tranService.eliminarTransaccion(idtransaccion));
    }

}

package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Movimientos;
import com.itzel.servicio.existencias.MovimientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/movimientos")
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
    //Encontrar el último numero de los movimientos para generar el secuencial diferenciando ingresos y salidas
    @GetMapping("/last")
    public ResponseEntity<Integer> findUltimoNumero(@RequestParam short tipmov){
        Integer number = movimientoService.findUltimoNumero(tipmov);
        if(number == null){
            number = 0;
        }
        return ResponseEntity.ok(number);
    }
    //Verificar si existe el numero de movimiento por tipo y numero
    @GetMapping("/exist")
    public ResponseEntity<Boolean> existsByTipoAndNumero(@RequestParam short tipmov, @RequestParam Long numero){
        return ResponseEntity.ok(movimientoService.existsByTipoAndNumero(tipmov, numero));
    }
    @GetMapping
    public ResponseEntity<List<Movimientos>> getAllMovimientos(){
        List<Movimientos> movimientos = movimientoService.getAllMovimientos();
        if(movimientos.isEmpty()){
            return ResponseEntity.noContent().build();
        }
        return  ResponseEntity.ok(movimientos);
    }
    //Find by Idmovimiento
    @GetMapping("/{idmovimiento}")
    public ResponseEntity<Movimientos> getByIdMovimiento(@PathVariable short idmovimiento){
        return ResponseEntity.ok(movimientoService.findByIdMovimiento(idmovimiento));
    }
    //Update movimiento
    @PutMapping
    public ResponseEntity<Movimientos> updateMovimiento(@RequestBody Movimientos m){
        return ResponseEntity.ok(movimientoService.updateMovimiento(m));
    }

    // Encontrar por tipo de movimiento y nombre beneficiario
    @GetMapping("/tipmov-nombene")
    public ResponseEntity<List<Movimientos>> buscar(
            @RequestParam("tipmov") short tipmov,
            @RequestParam("nomben") String nomben) {

        List<Movimientos> resultados = movimientoService.buscarPorTipoYNombre(tipmov, nomben);
        return ResponseEntity.ok(resultados);
    }
    //Encontrar movimientos de tipo entre numeros de movimientos
    @GetMapping("/num-between")
    public ResponseEntity<List<Movimientos>>findByTipmovAndNumeroBetween(@RequestParam Long tipmov,@RequestParam Long desde,@RequestParam Long hasta){
        return ResponseEntity.ok(movimientoService.findByTipmovAndNumeroBetween(tipmov, desde, hasta));
    }


}

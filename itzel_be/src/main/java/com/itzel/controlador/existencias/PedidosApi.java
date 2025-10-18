package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Pedidos;
import com.itzel.servicio.existencias.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/pedidos")
@CrossOrigin("*")
public class PedidosApi {
    private final PedidoService pedidoService;
    //Obtener los pedidos por IdPedido
    @GetMapping("/{idpedido}")
    public ResponseEntity<Pedidos> findByIdpedido(@PathVariable short idpedido){
        Pedidos pedido = pedidoService.findById(idpedido);
        return (pedido != null)
                ? ResponseEntity.ok(pedido)
                : ResponseEntity.notFound().build();
    }
    //Encontrar el último numero de los pedidos para generar el secuencial de los pedidos
    @GetMapping("/last")
    public ResponseEntity<Integer> findLastNumberOfPedido(){
        return ResponseEntity.ok(pedidoService.findUltimoNumero());
    }

    // Obtener todos los pedidos
    @GetMapping
    public ResponseEntity<List<Pedidos>> listar() {
        return ResponseEntity.ok(pedidoService.listar());
    }
    // Buscar por rango de fechas
    @GetMapping("/fecha")
    public ResponseEntity<List<Pedidos>> buscarPorFecha(
            @RequestParam("inicio") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inicio,
            @RequestParam("fin") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fin) {

        return ResponseEntity.ok(pedidoService.buscarPorFecha(inicio, fin));
    }

    // Buscar por rango de números
    @GetMapping("/numero")
    public ResponseEntity<List<Pedidos>> buscarPorNumero(
            @RequestParam("inicio") Long inicio,
            @RequestParam("fin") Long fin) {

        return ResponseEntity.ok(pedidoService.buscarPorNumero(inicio, fin));
    }

    // Buscar por descripción (parcial)
    @GetMapping("/descripcion")
    public ResponseEntity<List<Pedidos>> buscarPorDescripcion(@RequestParam("descripcion") String descripcion) {
        return ResponseEntity.ok(pedidoService.buscarPorDescripcion(descripcion));
    }

    // Buscar por nombre del beneficiario
    @GetMapping("/beneficiario")
    public ResponseEntity<List<Pedidos>> buscarPorNombreBeneficiario(@RequestParam("nombre") String nombre) {
        return ResponseEntity.ok(pedidoService.buscarPorNombreBeneficiario(nombre));
    }

    // Guardar o actualizar pedido
    @PostMapping
    public ResponseEntity<Pedidos> guardar(@RequestBody Pedidos pedido) {
        Pedidos nuevo = pedidoService.guardar(pedido);
        return ResponseEntity.ok(nuevo);
    }

    // Eliminar pedido
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable short idpedido) {
        pedidoService.eliminar(idpedido);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/page")
    public ResponseEntity<Page<Pedidos>> listarPaginado(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "idpedido") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir) {

        return ResponseEntity.ok(pedidoService.listarPaginado(page, size, sortBy, sortDir));
    }


    

}

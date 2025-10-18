package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Pedidos;
import com.itzel.servicio.existencias.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/pedidos")
@CrossOrigin("*")
public class PedidosApi {
    private final PedidoService pedidoService;
    //LISTAR TODOS LOS PEDIDOS
    @GetMapping
    public ResponseEntity<List<Pedidos>> findAllPedidos(){
        return ResponseEntity.ok(pedidoService.findAll());
    }
    //Obtener los pedidos por IdPedido
    @GetMapping("/{idpedido}")
    public ResponseEntity<Pedidos> findByIdpedido(@PathVariable short idpedido){
        return ResponseEntity.ok(pedidoService.findById(idpedido));
    }
    //Encontrar el último numero de los pedidos para generar el secuencial de los pedidos
    @GetMapping("/last")
    public ResponseEntity<Integer> findLastNumberOfPedido(){
        return ResponseEntity.ok(pedidoService.findUltimoNumero());
    }
    //Guardar nuevo pedido
    @PostMapping
    public ResponseEntity<Pedidos> savePedido(@RequestBody Pedidos p){
        return ResponseEntity.ok(pedidoService.save(p));
    }

}

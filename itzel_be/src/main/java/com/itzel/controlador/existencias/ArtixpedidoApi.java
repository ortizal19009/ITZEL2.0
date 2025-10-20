package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artixpedido;
import com.itzel.servicio.existencias.ArtixpedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/artixpedido")
@CrossOrigin("*")
public class ArtixpedidoApi {
    private final ArtixpedidoService artxpedService;
    @GetMapping("/pedido/{idpedido}")
    public ResponseEntity<List<Artixpedido>> findByIdpedido(@PathVariable short idpedido){
        return ResponseEntity.ok(artxpedService.findByIdpedido(idpedido));
    }
    @GetMapping("/articulos/{idarticulo}")
    public ResponseEntity<List<Artixpedido>> findByIdarticulo(@PathVariable short idarticulo){
        return ResponseEntity.ok(artxpedService.findByIdarticulo(idarticulo));
    }
    @PostMapping
    public ResponseEntity<Artixpedido> save(@RequestBody Artixpedido ap){
        return ResponseEntity.ok(artxpedService.save(ap));
    }
    @PutMapping("/delete_aritculo")
    public ResponseEntity<String> updateArtixpedido(@RequestParam short idpedido, @RequestBody List<Articulos> articulo){
        return ResponseEntity.ok(artxpedService.updateAll(idpedido, articulo));
    }
}

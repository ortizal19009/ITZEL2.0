package com.itzel.controlador.existencias;

import com.itzel.DTO.existencias.ArticulosDTO;
import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artixpedido;
import com.itzel.servicio.existencias.ArtixpedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/artixpedido")
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
    public ResponseEntity<String> updateArtixpedido(@RequestParam short idpedido, @RequestParam short usumodi, @RequestParam String fecmodi, @RequestBody List<ArticulosDTO> articulo){
        Timestamp timestamp = Timestamp.valueOf(fecmodi.replace("T", " ").replace("Z", "").substring(0, 19));
        return ResponseEntity.ok(artxpedService.updateAll(idpedido, usumodi, timestamp ,articulo));
    }
}

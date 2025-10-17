package com.itzel.controlador.existencias;


import com.itzel.modelo.existencias.Articulos;
import com.itzel.servicio.existencias.ArticuloService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/articulos")
@CrossOrigin("*")
public class ArticulosApi {

    private final ArticuloService artiService;

    // Buscar artículos por filtros: codigo, codcue y nombre, o una combinación
    @GetMapping("/buscar")
    public List<Articulos> buscarArticulos(
            @RequestParam(required = false) String codigo,
            @RequestParam(required = false) String codcue,
            @RequestParam(required = false) String nombre) {
        return artiService.buscarPorFiltros(codigo, codcue, nombre);
    }

    // OJO: No usar @PathVariable porque cuando el nombre tiene / o caracteres especiales no funciona
    // @GetMapping("/valnombre/{nombre}")
    // public ResponseEntity<Boolean> valNombre(@PathVariable String nombre) {
    //    boolean existe = artiService.valNombre(nombre);
    //    return ResponseEntity.ok(existe);
    // }
    // Valida nombre
    @GetMapping("/valnombre")
    public ResponseEntity<Boolean> valNombre(@RequestParam String nombre) {
        boolean existe = artiService.valNombre(nombre);
        return ResponseEntity.ok(existe);
    }

    // Valida código
    @GetMapping("/valcodigo/{codigo}")
    public ResponseEntity<Boolean> validarCodigo(@PathVariable String codigo) {
        boolean existe = artiService.valCodigo(codigo);
        return ResponseEntity.ok(existe);
    }
    @GetMapping("/data_search")
    // Buscar por nombre, cuenta o codigo de partida
    public ResponseEntity<List<Articulos>> buscar(@RequestParam String dato) {
        return ResponseEntity.ok(artiService.buscarCombinado(dato));
        // o: service.buscarCombinadoInteligente(dato);
    }
    // Guarda nuevo
    @PostMapping
    public ResponseEntity<Articulos> saveArticulo(@RequestBody Articulos x) {
        return ResponseEntity.ok(artiService.save(x));
    }

    // Buscar por idarticulo
    @GetMapping("/{idarticulo}")
    public ResponseEntity<Articulos> getByIdarticulo(@PathVariable Short idarticulo) {
        Articulos articulo = artiService.findById(idarticulo)
                .orElseThrow();
        return ResponseEntity.ok(articulo);
    }

    // Actualizar
    @PutMapping("/{idarticulo}")
    public Articulos actualizarArticulo(@PathVariable Short idarticulo, @RequestBody Articulos x) {
        return artiService.actualizarArticulo(idarticulo, x);
    }

    // Eliminar
    @DeleteMapping("/{idarticulo}")
    public ResponseEntity<Void> deleteArticulo(@PathVariable("idarticulo") Short idarticulo) {
        artiService.deleteById(idarticulo);
        return ResponseEntity.noContent().build();
    }

}

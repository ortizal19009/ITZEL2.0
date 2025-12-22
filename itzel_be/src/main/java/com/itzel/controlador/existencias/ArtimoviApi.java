package com.itzel.controlador.existencias;

import com.itzel.DTO.existencias.ArtimoviDTO;
import com.itzel.DTO.existencias.ArtimoviRequestDTO;
import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artimovi;
import com.itzel.repositorio.existencias.ArticulosR;
import com.itzel.servicio.existencias.ArtimoviService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/artimovi")
public class ArtimoviApi {
    private final ArtimoviService artimoviService;
    private final ArticulosR articulosR;
    @PostMapping
    public ResponseEntity<Object> saveArtmovi(@RequestBody Artimovi am){
        Map<String, Object> response = new HashMap<>();
    response.put("success",200);
    return ResponseEntity.ok( response);
    }

    @PostMapping("/guardar-artimovi")
    public ResponseEntity<?> save(@Valid @RequestBody ArtimoviRequestDTO dto, BindingResult br) {

        if (br.hasErrors()) {
            var errores = br.getFieldErrors().stream()
                    .collect(Collectors.toMap(
                            e -> e.getField(),
                            e -> e.getDefaultMessage(),
                            (a, b) -> a
                    ));
            return ResponseEntity.badRequest().body(errores);
        }

        Short idMov = artimoviService.guardarMovimiento(dto);
        return ResponseEntity.ok(Map.of(
                "mensaje", "Guardado correctamente",
                "idmovimiento", idMov
        ));
    }


    @GetMapping("/by-movimiento")
    public ResponseEntity<List<Artimovi>> getByIdMovimiento(@RequestParam Long idMovimiento){
        return ResponseEntity.ok(artimoviService.findByIdMovimiento(idMovimiento));

    }

}

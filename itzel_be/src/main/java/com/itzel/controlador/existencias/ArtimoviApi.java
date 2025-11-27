package com.itzel.controlador.existencias;

import com.itzel.DTO.existencias.ArtimoviDTO;
import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artimovi;
import com.itzel.servicio.existencias.ArtimoviService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/artimovi ")
public class ArtimoviApi {
    private ArtimoviService artimoviService;
    @PostMapping
    public ResponseEntity<Object> saveArtmovi(@RequestBody Artimovi am){
        Map<String, Object> response = new HashMap<>();
    response.put("success",200);
    return ResponseEntity.ok( response);
    }

    @PostMapping("/guardar-artimovi")
    public ResponseEntity<?> save(@RequestBody ArtimoviDTO dto) {

        List<Articulos> articulos = dto.getArticulos(); // Aquí ya recibes la lista

        // Ejemplo de acceso
        articulos.forEach(a -> {
            System.out.println("Artículo: " + a.getNombre());
        });
        artimoviService.guardarMovimiento(dto);
        return ResponseEntity.ok("Recibido");
    }

}

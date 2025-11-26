package com.itzel.controlador.existencias;

import com.itzel.modelo.existencias.Artimovi;
import com.itzel.servicio.existencias.ArtimoviService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/artimovi ")
public class ArtimoviApi {
    private ArtimoviService artimoviService;
    @PostMapping
    public ResponseEntity<Object> saveArtmovi(@RequestBody Artimovi am){
        Map<String, Object> response = new HashMap<>();

return response;
    }
}

package com.itzel.controlador.contabilidad;


import com.itzel.modelo.contabilidad.Departamentos;
import com.itzel.servicio.contabilidad.DepartamentoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/departamentos")
@CrossOrigin("*")

public class DepartamentosApi {

    private final DepartamentoService deparService;

    // Obtiene todos los Departamentos ordenados por nomdep
    @GetMapping()
    public ResponseEntity<List<Departamentos>> todos() {
        List<Departamentos> lista = deparService.obtenerOrdenadosPorNomdep();
        return ResponseEntity.ok(lista);
    }

}

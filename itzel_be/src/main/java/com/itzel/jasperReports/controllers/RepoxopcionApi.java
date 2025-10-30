package com.itzel.jasperReports.controllers;

import com.itzel.jasperReports.modelo.Repoxopcion;
import com.itzel.jasperReports.services.RepoxopcionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/repoxopcion")
public class RepoxopcionApi {
    private final RepoxopcionService repoxopService;
    // Repoxopcion para datalist
    @GetMapping("/codigo")
    public ResponseEntity<List<Repoxopcion>> findPorCodigo(@RequestParam String codigo) {
        List<Repoxopcion> repoxopcion = repoxopService.findRepoxopcionPorCodigo(codigo);
        return ResponseEntity.ok(repoxopcion);
    }

}

package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Tiptran;
import com.itzel.servicio.contabilidad.TiptranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/tiptran")
@CrossOrigin("*")
public class TiptranApi {
    @Autowired
    private TiptranService tiptranService;

    @GetMapping
    public ResponseEntity<List<Tiptran>> getAllTiptran(){
        return ResponseEntity.ok(tiptranService.findAll());
    }
}

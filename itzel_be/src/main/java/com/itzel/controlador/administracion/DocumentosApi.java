package com.itzel.controlador.administracion;

import com.itzel.modelo.administracion.Documentos;
import com.itzel.servicio.administracion.DocumentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/documentos")
public class DocumentosApi {
    @Autowired
    private DocumentoService documentoService;

    @GetMapping
    ResponseEntity<List<Documentos>> getAllDocuments(){
        return ResponseEntity.ok(documentoService.findAll());
    }
}

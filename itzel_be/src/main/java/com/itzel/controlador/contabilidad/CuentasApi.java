package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import com.itzel.servicio.contabilidad.CuentasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cuentas")
@CrossOrigin("*")
public class CuentasApi {
    @Autowired
    private CuentasService cuentasService;

    @GetMapping
    public ResponseEntity<List<Cuentas>> getAll(){
        return ResponseEntity.ok(cuentasService.findAll());
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Cuentas c){
        return ResponseEntity.ok(cuentasService.save(c));
    }
}

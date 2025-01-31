package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.servicio.contabilidad.PresupuestoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/presupuesto")
@CrossOrigin("*")
public class PresupuestoApi {
    @Autowired
    private PresupuestoService presupuestoService;
    @GetMapping
    public ResponseEntity<Page<Presupuesto>> getdAllByPage(@RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presupuestoService.findAllByPage(page, size));
    }
}

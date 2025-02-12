package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.servicio.contabilidad.PresupuestoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

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
    @GetMapping("/tippar")
    public ResponseEntity<Page<Presupuesto>> getByTipparPageable(@RequestParam int tippar, @RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presupuestoService.findByTipparPageable(tippar, page, size));
    }
    @GetMapping("/codnom")
    public ResponseEntity<Page<Presupuesto>> getByParDenom(@RequestParam String dato, @RequestParam int tippar, @RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presupuestoService.findByParDenom( dato.toLowerCase(), tippar, page, size));
    }
    @PostMapping
    public ResponseEntity<Presupuesto> savePresupuesto(@RequestBody Presupuesto presupuesto){
        return  ResponseEntity.ok(presupuestoService.save(presupuesto));
    }
    @GetMapping("/codpar")
    public ResponseEntity<Presupuesto> getByCodPar(@RequestParam String codpar){
        return ResponseEntity.ok(presupuestoService.findByCodPar(codpar));

    }
    @GetMapping("/byId")
    public ResponseEntity<Optional<Presupuesto>> findById(@RequestParam Long idpresupuesto){
        return ResponseEntity.ok(presupuestoService.findById(idpresupuesto));
    }

}

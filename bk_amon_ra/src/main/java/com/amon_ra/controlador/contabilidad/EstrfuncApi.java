package com.amon_ra.controlador.contabilidad;

import com.amon_ra.modelo.contabilidad.Estrfunc;
import com.amon_ra.servicio.contabilidad.EstrfuncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/estrfunc")
@CrossOrigin("*")
public class EstrfuncApi {
    @Autowired
    private EstrfuncService estrfuncService;

    @GetMapping
    public ResponseEntity<List<Estrfunc>> getAll(){
        List<Estrfunc> estrfuncs  = estrfuncService.findAll(Sort.by(Sort.Order.asc("codigo")));
        if (estrfuncs != null){
            return ResponseEntity.ok(estrfuncs);
        }
        return  ResponseEntity.noContent().build();
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Estrfunc e){
        return ResponseEntity.ok(estrfuncService.save(e));
    }
    @PutMapping
    public ResponseEntity<Object> update(@RequestParam Long idestrfunc, @RequestBody Estrfunc e){
        Estrfunc _e = estrfuncService.findById(idestrfunc).orElse(null);
        assert _e != null;
        _e.setCodigo(e.getCodigo());
        _e.setNombre(e.getNombre());
        _e.setMovimiento(e.getMovimiento());
        _e.setIdestructura_estructura(e.getIdestructura_estructura());
        return ResponseEntity.ok(estrfuncService.update(_e));
    }
}

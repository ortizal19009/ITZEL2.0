package com.amon_ra.controlador.contabilidad;

import com.amon_ra.modelo.contabilidad.Proyectos;
import com.amon_ra.servicio.contabilidad.ProyectosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/estrfunc")
@CrossOrigin("*")
public class ProyectosApi {
    @Autowired
    private ProyectosService proyectosService;

    @GetMapping
    public ResponseEntity<List<Proyectos>> getAll(){
        List<Proyectos> estrfuncs  = proyectosService.findAll(Sort.by(Sort.Order.asc("codigo")));
        if (estrfuncs != null){
            return ResponseEntity.ok(estrfuncs);
        }
        return  ResponseEntity.noContent().build();
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Proyectos e){
        return ResponseEntity.ok(proyectosService.save(e));
    }
    @PutMapping
    public ResponseEntity<Object> update(@RequestParam Long idestrfunc, @RequestBody Proyectos e){
        Proyectos _e = proyectosService.findById(idestrfunc).orElse(null);
        assert _e != null;
        _e.setCodigo(e.getCodigo());
        _e.setNombre(e.getNombre());
        _e.setMovimiento(e.getMovimiento());
        _e.setIdestructura_estructura(e.getIdestructura_estructura());
        return ResponseEntity.ok(proyectosService.update(_e));
    }
    @GetMapping("/validar/codigo")
    public ResponseEntity<Boolean> getByCodigo(@RequestParam String codigo){
        Proyectos estrfunc = proyectosService.findByCodigo(codigo);
        return ResponseEntity.ok(estrfunc != null);
    }
    @GetMapping("/validar/nombre")
    public ResponseEntity<Boolean> getByNombre(@RequestParam String nombre){
        Proyectos estrfunc = proyectosService.findByNombre(nombre);
        return ResponseEntity.ok(estrfunc != null);
    }
}

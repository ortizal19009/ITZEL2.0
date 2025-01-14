package com.amon_ra.controlador.contabilidad;

import com.amon_ra.modelo.contabilidad.Proyectos;
import com.amon_ra.servicio.contabilidad.ProyectosService;
import com.amon_ra.servicio.jasperreport.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/proyectos")
@CrossOrigin("*")
public class ProyectosApi {
    @Autowired
    private ProyectosService proyectosService;
    @Autowired
    private ReportService reportService;

    @GetMapping
    public ResponseEntity<List<Proyectos>> getAll(){
        List<Proyectos> proyectos  = proyectosService.findAll(Sort.by(Sort.Order.asc("codigo")));
        if (proyectos != null){
            return ResponseEntity.ok(proyectos);
        }
        return  ResponseEntity.noContent().build();
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Proyectos e){
        return ResponseEntity.ok(proyectosService.save(e));
    }
    @PutMapping
    public ResponseEntity<Object> update(@RequestParam Long idproyecto, @RequestBody Proyectos e){
        Proyectos _e = proyectosService.findById(idproyecto).orElse(null);
        assert _e != null;
        _e.setCodigo(e.getCodigo());
        _e.setNombre(e.getNombre());
        _e.setMovimiento(e.getMovimiento());
        _e.setIdestructura_estructura(e.getIdestructura_estructura());
        return ResponseEntity.ok(proyectosService.update(_e));
    }
    @GetMapping("/validar/codigo")
    public ResponseEntity<Boolean> getByCodigo(@RequestParam String codigo){
        Proyectos proyectos = proyectosService.findByCodigo(codigo);
        return ResponseEntity.ok(proyectos != null);
    }
    @GetMapping("/validar/nombre")
    public ResponseEntity<Boolean> getByNombre(@RequestParam String nombre){
        Proyectos proyectos = proyectosService.findByNombre(nombre);
        return ResponseEntity.ok(proyectos != null);
    }
    @GetMapping("/{idproyecto}")
    public ResponseEntity<Optional<Proyectos>> getById(@PathVariable Long idproyecto){
        Proyectos proyecto = proyectosService.findById(idproyecto).orElse(null);
        if(proyecto != null ){
            return ResponseEntity.ok(Optional.of(proyecto));
        }else {
            return ResponseEntity.noContent().build();
        }
    }
    @DeleteMapping("/{idproyecto}")
    public  ResponseEntity<Object> deleteProyecto(@PathVariable Long idproyecto){
        return ResponseEntity.ok(proyectosService.delete(idproyecto));
    }
    @GetMapping("/cod-mayor")
    public ResponseEntity<List<Proyectos>> getByCodigoMayor (@RequestParam String codigo){
        return ResponseEntity.ok(proyectosService.findByCodigoMayor(codigo));
    }

    //GENERAR REPORTES DE JASPER REPORT
    @GetMapping("/jasperReport/appProyectos")
    public ResponseEntity<byte[]> reportAllProyectos(@RequestParam String nameReport){
        try{
            byte[] report = reportService.generarReportes(nameReport);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition", "inline; filename="+nameReport);
            return new ResponseEntity<>(report, headers, HttpStatus.OK);
        }
        catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}

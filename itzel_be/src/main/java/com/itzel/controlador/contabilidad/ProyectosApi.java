package com.itzel.controlador.contabilidad;

import com.itzel.config.jasperConfig.JasperInterface;
import com.itzel.config.jasperConfig.JasperReportService;
import com.itzel.config.jasperConfig.ReportModelDTO;
import com.itzel.interfaces.contabilidad.Proyectos_rep_int;
import com.itzel.modelo.contabilidad.Proyectos;
import com.itzel.servicio.contabilidad.ProyectosService;
import net.sf.jasperreports.engine.JRException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Sort;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/proyectos")
@CrossOrigin("*")
public class ProyectosApi {
    private static final Logger logger = LoggerFactory.getLogger(ProyectosApi.class);

    @Autowired
    private ProyectosService proyectosService;
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
    @GetMapping("/reportes/porniveles")
    public ResponseEntity<List<Proyectos_rep_int>> getByNivel(@RequestParam Long nivel){
        return ResponseEntity.ok(proyectosService.findByNivel(nivel));
    }
    @GetMapping("/reportes/porgrupo")
    public ResponseEntity<List<Proyectos_rep_int>> getByGrupo(@RequestParam String codigo){
        return ResponseEntity.ok(proyectosService.findByGrupo(codigo));
    }
private JasperReportService jasperReportService;

    public ProyectosApi(JasperReportService jasperReportService) {
        this.jasperReportService = jasperReportService;
    }

    @GetMapping("/jasperreport/all")
    public ResponseEntity<byte[]> generarReporte(){
        try{
            byte[] report = jasperReportService.generarReporte("listaProyectos");
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.add("Content-Disposition", "inline; fileName=report.pdf");
            return new ResponseEntity<>(report, headers,HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


}

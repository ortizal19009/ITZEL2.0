package com.amon_ra.controlador.contabilidad;

import com.amon_ra.config.jasperConfig.JasperInterface;
import com.amon_ra.config.jasperConfig.JasperReportService;
import com.amon_ra.config.jasperConfig.ReportModelDTO;
import com.amon_ra.interfaces.contabilidad.Proyectos_rep_int;
import com.amon_ra.modelo.contabilidad.Proyectos;
import com.amon_ra.servicio.contabilidad.ProyectosService;
import jakarta.annotation.Resource;
import net.sf.jasperreports.engine.JRException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Sort;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
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
    @Autowired
    private JasperInterface jasperInterface;
    @Autowired
    private JasperReportService jasperReportService;
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

    //GENERAR REPORTES DE JASPER REPORT
    @GetMapping("/jasperReport/allProyectos")
    public ResponseEntity<InputStreamResource> reportAllProyectos() throws JRException, IOException, SQLException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("fileName","listaProyectos");
        ReportModelDTO dto = jasperInterface.GenerarReportes(params);
        InputStreamResource streamResource= new InputStreamResource(dto.getStream());
        MediaType mediaType = null;
        mediaType = MediaType.APPLICATION_PDF;
        return ResponseEntity.ok().header("Content-Disposition", "inline; filename=\""+dto.getFileName()+"\"")
                .contentLength(dto.getLength()).contentType(mediaType).body(streamResource);
    }
}

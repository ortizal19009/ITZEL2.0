package com.itzel.controlador.contabilidad;

import com.itzel.config.jasperConfig.ReportDTO;
import com.itzel.config.jasperConfig.ReportService;
import com.itzel.config.jasperConfig.Report_i;
import com.itzel.interfaces.contabilidad.Proyectos_rep_int;
import com.itzel.modelo.contabilidad.Proyectos;
import com.itzel.servicio.contabilidad.ProyectosService;
import net.sf.jasperreports.engine.JRException;
import org.apache.coyote.Response;
import org.springframework.beans.BeanUtils;
import org.springframework.core.io.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.core.io.InputStreamResource;


import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@RestController
@RequestMapping("/proyectos")
public class ProyectosApi {
    @GetMapping
    public ResponseEntity<List<Proyectos>> getAll(
            @RequestParam(required = false) String codigo,
            @RequestParam(required = false) String nombre) {

        List<Proyectos> proyectos = new ArrayList<>();
        if (codigo == null && nombre == null) {
            proyectos = proyService.findByCodigoNotOrderByCodigoAsc("00");
        }
        if (codigo != null) {
            proyectos = proyService.findByCodigoLike(codigo);
        }
        if (nombre != null) {
            proyectos = proyService.findByNameLike(nombre.toLowerCase());
        }
        if (proyectos == null || proyectos.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(proyectos);
    }


    private static final Logger logger = LoggerFactory.getLogger(ProyectosApi.class);
    @Autowired
    private ProyectosService proyService;

    @Autowired
    private ReportService jasperReportService;

    @Autowired
    private Report_i reportI;
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Proyectos e){
        return ResponseEntity.ok(proyService.save(e));
    }
    @PutMapping
    public ResponseEntity<Proyectos> update(@RequestParam short idproyecto, @RequestBody Proyectos e) {
        Proyectos _e = proyService.findById(idproyecto)
                .orElseThrow(() -> new RuntimeException("Proyecto no encontrado"));

        // Copiar todas las propiedades excepto las que no deben actualizarse
        BeanUtils.copyProperties(e, _e, "idproyecto", "usucrea", "feccrea");

        Proyectos actualizado = proyService.saveOne(_e);
        return ResponseEntity.ok(actualizado);
    }
    @GetMapping("/validar/codigo")
    public ResponseEntity<Boolean> getByCodigo(@RequestParam String codigo){
        Proyectos proyectos = proyService.findByCodigo(codigo);
        return ResponseEntity.ok(proyectos != null);
    }
    @GetMapping("/validar/nombre")
    public ResponseEntity<Boolean> getByNombre(@RequestParam String nombre){
        Proyectos proyectos = proyService.findByNombre(nombre);
        return ResponseEntity.ok(proyectos != null);
    }
    @GetMapping("/{idproyecto}")
    public ResponseEntity<Optional<Proyectos>> getById(@PathVariable short idproyecto){
        Proyectos proyecto = proyService.findById(idproyecto).orElse(null);
        if(proyecto != null ){
            return ResponseEntity.ok(Optional.of(proyecto));
        }else {
            return ResponseEntity.noContent().build();
        }
    }
    @DeleteMapping("/{idproyecto}")
    public  ResponseEntity<Object> deleteProyecto(@PathVariable short idproyecto){
        return ResponseEntity.ok(proyService.delete(idproyecto));
    }
    @GetMapping("/cod-mayor")
    public ResponseEntity<List<Proyectos>> getByCodigoMayor (@RequestParam String codigo){
        return ResponseEntity.ok(proyService.findByCodigoMayor(codigo));
    }
    @GetMapping("/reportes/porniveles")
    public ResponseEntity<List<Proyectos_rep_int>> getByNivel(@RequestParam Long nivel){
        return ResponseEntity.ok(proyService.findByNivel(nivel));
    }
    @GetMapping("/reportes/porgrupo")
    public ResponseEntity<List<Proyectos_rep_int>> getByGrupo(@RequestParam String codigo){
        return ResponseEntity.ok(proyService.findByGrupo(codigo));
    }
    @GetMapping("/codnom")
    public ResponseEntity<List<Proyectos>> getByCodNom(@RequestParam String dato){
        return ResponseEntity.ok(proyService.findByCodNom(dato));
    }

    @GetMapping("/proyectosLike")
    public ResponseEntity<Map<String, Object>> findByCodigoLike(@RequestParam String codigo){
        List<Proyectos> proyectos = proyService.findByCodigoLike(codigo);
        Map<String, Object> response = new HashMap<>();
        if(proyectos.isEmpty()){
            response.put("message", "Datos no encontrados");
            response.put("status", "error");
        }else{
            response.put("message", "Datos encontrados");
            response.put("status", "success");
            response.put("body", proyectos);
        }
        return ResponseEntity.ok(response);
    }

    /*REPORTES DE JASPER REPORT*/
    @GetMapping("/reportes/proyectos/findall")
    public ResponseEntity<Resource> listAll()
            throws JRException, IOException, SQLException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("fileName", "listaProyectos");

        ReportDTO dto = reportI.generateReport(params);
        InputStreamResource streamResource = new InputStreamResource(dto.getStream());
        MediaType mediaType = null;
        mediaType = MediaType.APPLICATION_PDF;

        return ResponseEntity.ok().header("Content-Disposition", "inline; filename=\"" + dto.getFileName() + "\"")
                .contentLength(dto.getLength()).contentType(mediaType).body(streamResource);
    }
    @GetMapping("/reportes/proyectos/bynivel")
    public ResponseEntity<Resource> listByNivel(@RequestParam int nivel)
            throws JRException, IOException, SQLException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("nivel", nivel);
        params.put("fileName", "listaProyectosByNivel");

        ReportDTO dto = reportI.generateReport(params);
        InputStreamResource streamResource = new InputStreamResource(dto.getStream());
        MediaType mediaType = null;
        mediaType = MediaType.APPLICATION_PDF;

        return ResponseEntity.ok().header("Content-Disposition", "inline; filename=\"" + dto.getFileName() + "\"")
                .contentLength(dto.getLength()).contentType(mediaType).body(streamResource);
    }
    @GetMapping("/reportes/proyectos/bycodigo")
    public ResponseEntity<Resource> listByGrupo(@RequestParam String codigo)
            throws JRException, IOException, SQLException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("codigo", codigo);
        params.put("fileName", "listaProyectosBygrupo");
        ReportDTO dto = reportI.generateReport(params);
        InputStreamResource streamResource = new InputStreamResource(dto.getStream());
        MediaType mediaType = null;
        mediaType = MediaType.APPLICATION_PDF;

        return ResponseEntity.ok().header("Content-Disposition", "inline; filename=\"" + dto.getFileName() + "\"")
                .contentLength(dto.getLength()).contentType(mediaType).body(streamResource);
    }

    // Proyectos para datalist
    @GetMapping("/porcodigo")
    public ResponseEntity<List<Proyectos>> findProyectosPorCodigo(@RequestParam String codigo) {
        List<Proyectos> proyectos = proyService.findProyectosPorCodigo(codigo);
        return ResponseEntity.ok(proyectos);
    }



}

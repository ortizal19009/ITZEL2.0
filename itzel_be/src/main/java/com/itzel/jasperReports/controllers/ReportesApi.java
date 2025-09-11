package com.itzel.jasperReports.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itzel.jasperReports.modelo.Reportes;
import com.itzel.jasperReports.repositories.ReportesR;
import com.itzel.jasperReports.services.ReporteService;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/reportesjr")
@CrossOrigin("*")
public class ReportesApi {
    @Autowired
    private ReporteService reporteService;
    private final ReportesR repo;
    private final ObjectMapper objectMapper;

    public ReportesApi(ReportesR repo, ObjectMapper objectMapper) {
        this.repo = repo;
        this.objectMapper = objectMapper;
    }

    /**
     * Subir un nuevo reporte (jrxml + jasper) y extraer parámetros
     */
    @PostMapping("/upload")
    public ResponseEntity<?> uploadReporte(
            @RequestParam("nombre") String nombre,
            @RequestParam(value = "descripcion", required = false) String descripcion,
            @RequestParam("jrxml") MultipartFile jrxmlFile,
            @RequestParam("jasper") MultipartFile jasperFile) {

        try {
            Reportes reporte = new Reportes();
            reporte.setNombre(nombre);
            reporte.setDescripcion(descripcion);
            reporte.setArchivoJrxml(jrxmlFile.getBytes());
            reporte.setArchivoJasper(jasperFile.getBytes());

            // Extraer parámetros del jasper
            InputStream jasperStream = new ByteArrayInputStream(jasperFile.getBytes());
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperStream);

            List<Map<String, Object>> parametros = new ArrayList<>();
            for (JRParameter p : jasperReport.getParameters()) {
                if (!p.isSystemDefined()) {
                    Map<String, Object> param = new HashMap<>();
                    param.put("nombre", p.getName());
                    param.put("tipo", p.getValueClassName());
                    parametros.add(param);
                }
            }
            reporte.setParametros(objectMapper.writeValueAsString(parametros));

            repo.save(reporte);

            return ResponseEntity.status(HttpStatus.CREATED).body("Reporte cargado correctamente");

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error al guardar el reporte: " + e.getMessage());
        }
    }

    /**
     * Listar todos los reportes
     */
    @GetMapping
    public ResponseEntity<List<Reportes>> listarReportes() {
        return ResponseEntity.ok(repo.findAll());
    }

    /**
     * Obtener un reporte por ID
     */
    @GetMapping("/{idreporte}")
    public ResponseEntity<?> obtenerReporte(@PathVariable Long idreporte) {
        return repo.findById(idreporte)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    /**
     * Obtener un reporte por nombre
     */
    @GetMapping("/nombre/{nombre}")
    public ResponseEntity<?> obtenerPorNombre(@PathVariable String nombre) {
        Reportes reporte = repo.findByNombre(nombre);
        if (reporte != null) {
            return ResponseEntity.ok(reporte);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Reporte no encontrado");
    }
}

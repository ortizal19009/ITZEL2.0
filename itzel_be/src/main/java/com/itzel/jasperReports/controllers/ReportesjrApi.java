package com.itzel.jasperReports.controllers;

// import java.io.ByteArrayInputStream;
// import java.util.LinkedHashMap;
import java.util.List;
// import java.util.Map;

import com.itzel.jasperReports.modelo.Reportesjr;
import com.itzel.jasperReports.services.ReportejrService;
import org.springframework.http.HttpStatus;
// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/reportesjr")
public class ReportesjrApi {

    private final ReportejrService repojrService;

    // Buscar reportesjr por nombre y desrep ordenados por codrep
    @GetMapping("/busca")
    public ResponseEntity<List<Reportesjr>> buscarPorOpcionNomrepYDesrep(@RequestParam("codigo") String codigo,
                                                                         @RequestParam("nomrep") String nomrep,
                                                                         @RequestParam("desrep") String desrep) {
        List<Reportesjr> resultados = repojrService.buscarPorOpcionNomrepYDesrep(codigo, nomrep, desrep);
        return ResponseEntity.ok(resultados);
    }

    // Valida nomrep
    @GetMapping("/valnomrep/{nomrep}")
    public ResponseEntity<Boolean> valNomrep(@PathVariable String nomrep) {
        boolean existe = repojrService.valNomrep(nomrep);
        return ResponseEntity.ok(existe);
    }

    // Reporte por id
    @GetMapping("/{id}")
    public ResponseEntity<Reportesjr> obtenerPorId(@PathVariable Short id) {
        return repojrService.buscaPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Reporte por nombre
    @GetMapping("/nomrep/{nomrep}")
    public ResponseEntity<Reportesjr> buscarPorNombre(@PathVariable("nomrep") String nomrep) {
        Reportesjr reporte = repojrService.findByNomrep(nomrep);
        if (reporte != null) {
            return ResponseEntity.ok(reporte);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Buscar todos los reportes con un Repoxopcion_Codigo específico
    @GetMapping("/codigo/{codigo}")
    public ResponseEntity<List<Reportesjr>> obtenerPorCodigo(@PathVariable String codigo) {
        List<Reportesjr> reportes = repojrService.buscaPorRepoxopcion_CodigoOrderByNomrep(codigo);
        return ResponseEntity.ok(reportes);
    }

    // @PostMapping(consumes = "multipart/form-data")
    // public ResponseEntity<Reportesjr> guardarReporte(
    // @RequestParam("idrepoxopcion") Short idrepoxopcion,
    // // @RequestParam("codrep") String codrep,
    // @RequestParam("nomrep") String nomrep,
    // @RequestParam("desrep") String desrep,
    // @RequestParam("jrxml") MultipartFile jrxml,
    // @RequestParam("jasper") MultipartFile jasper) {
    // try {
    // Reportesjr reporte = new Reportesjr();
    // // Genera la entidad relacionada Repoxopcion
    // Repoxopcion repoxopcion = new Repoxopcion();
    // repoxopcion.setIdrepoxopcion(idrepoxopcion);
    // reporte.setRepoxopcion(repoxopcion);

    // reporte.setNomrep(nomrep);
    // reporte.setDesrep(desrep);
    // reporte.setJrxml(jrxml.getBytes());
    // reporte.setJasper(jasper.getBytes());

    // // 1️⃣ Compilar el JRXML (Ok para poder obtener los parametros del jrxml)
    // JasperReport jasperReport = JasperCompileManager.compileReport(
    // new ByteArrayInputStream(jrxml.getBytes()));

    // // 2️⃣ Obtener los parámetros del reporte, tipo y la propiedad anchoCampo
    // Map<String, Object> parametrosMap = new LinkedHashMap<>();

    // for (JRParameter param : jasperReport.getParameters()) {
    // if (!param.isSystemDefined()) {
    // String nomvar = param.getName();
    // String tipo = param.getValueClassName();

    // String anchoCampo = param.getPropertiesMap().getProperty("anchoCampo");
    // if (anchoCampo == null || anchoCampo.trim().isEmpty()) {
    // anchoCampo = "12";
    // }
    // String valorFinal = tipo + "|" + anchoCampo;

    // parametrosMap.put(nomvar, valorFinal);
    // }
    // }

    // // 3️⃣ Guardamos los parámetros en la columna JSONB
    // reporte.setParametros(parametrosMap);

    // // 4️⃣ Guardar en la DB
    // Reportesjr guardado = repojrService.guardar(reporte);
    // return ResponseEntity.ok(guardado);

    // } catch (Exception e) {
    // e.printStackTrace();
    // return ResponseEntity.badRequest().build();
    // }
    // }

    // Nuevo reporte
    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<Reportesjr> crearReporte(
            @RequestParam("idrepoxopcion") Short idrepoxopcion,
            @RequestParam("nomrep") String nomrep,
            @RequestParam("desrep") String desrep,
            @RequestParam("jrxml") MultipartFile jrxml,
            @RequestParam("jasper") MultipartFile jasper) {
        try {
            Reportesjr nuevo = repojrService.crearReporte(idrepoxopcion, nomrep, desrep, jrxml, jasper);
            return ResponseEntity.ok(nuevo);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // Para actualizar solo metadatos (sin archivos)
    @PutMapping("/{id}/metadatos")
    public ResponseEntity<Reportesjr> actualizarMetadatos(@PathVariable Short id,
                                                          @RequestParam("idrepoxopcion") Short idrepoxopcion,
                                                          @RequestParam("nomrep") String nomrep,
                                                          @RequestParam("desrep") String desrep) {
        Reportesjr actualizado = repojrService.actualizarSoloCampos(id, idrepoxopcion, nomrep, desrep);
        return ResponseEntity.ok(actualizado);
    }

    // Para actualizar archivos (jrxml y jasper)
    // @PutMapping(value = "/{id}/archivos", consumes = "multipart/form-data")
    // public ResponseEntity<Reportesjr> actualizarArchivos(@PathVariable Short id,
    //       @RequestParam("jrxml") MultipartFile jrxml,
    //       @RequestParam("jasper") MultipartFile jasper) {
    //    try {
    //       Reportesjr actualizado = repojrService.actualizarSoloArchivos(id, jrxml, jasper);
    //       return ResponseEntity.ok(actualizado);
    //    } catch (Exception e) { // Handles JRException, IOException, etc.
    //       e.printStackTrace();
    //       return ResponseEntity.badRequest().build();
    //    }
    // }

    // Actualizar todo (metadatos y archivos)
    @PutMapping(value = "/{id}", consumes = "multipart/form-data")
    public ResponseEntity<Reportesjr> actualizarCompleto(@PathVariable Short id,
                                                         @RequestParam("idrepoxopcion") Short idrepoxopcion,
                                                         @RequestParam("nomrep") String nomrep,
                                                         @RequestParam("desrep") String desrep,
                                                         @RequestParam("jrxml") MultipartFile jrxml,
                                                         @RequestParam("jasper") MultipartFile jasper) {
        try {
            Reportesjr actualizado = repojrService.actualizarCompleto(id, idrepoxopcion, nomrep, desrep, jrxml, jasper);
            return ResponseEntity.ok(actualizado);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Elimina
    @DeleteMapping("/{idreporte}")
    public ResponseEntity<Void> delete(@PathVariable("idreporte") Short idreporte) {
        repojrService.deleteById(idreporte);
        return ResponseEntity.noContent().build();
    }

}

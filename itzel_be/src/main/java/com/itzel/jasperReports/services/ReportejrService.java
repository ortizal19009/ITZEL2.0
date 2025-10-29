package com.itzel.jasperReports.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.itzel.jasperReports.modelo.Reportesjr;
import com.itzel.jasperReports.modelo.Repoxopcion;
import com.itzel.jasperReports.repositories.ReportesjrR;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.*;

@RequiredArgsConstructor
@Service
public class ReportejrService {

    private final ReportesjrR dao;

    // Buscar reportesjr por nombre y desrep ordenados por codrep
    public List<Reportesjr> buscarPorOpcionNomrepYDesrep(String codigo, String nomrep, String desrep) {
        return dao
                .findByRepoxopcion_CodigoStartingWithAndNomrepContainingIgnoreCaseAndDesrepContainingIgnoreCaseOrderByRepoxopcion_CodigoAsc(
                        codigo, nomrep, desrep);
    }

    // Reportes de un nomrep específico
    public List<Reportesjr> obtenerReportesPorNomrep(String nomrepBase) {
        return dao.findByNomrepStartingWithOrderByNomrep(nomrepBase);
    }

    // Buscar todos los reportes con un Repoxopcion_Codigo específico
    public List<Reportesjr> buscaPorRepoxopcion_CodigoOrderByNomrep(String codigo) {
        return dao.findByRepoxopcion_CodigoOrderByNomrep(codigo);
    }

    // Valida nomrep
    public boolean valNomrep(String nomrep) {
        return dao.existsByNomrep(nomrep);
    }

    // public Reportesjr guardar(Reportesjr reporte) {
    // if (dao.existsByNomrep(reporte.getNomrep())) {
    // throw new RuntimeException("Ya existe un reporte con el nombre: " +
    // reporte.getNomrep());
    // }
    // return dao.save(reporte);
    // }

    // Crear un nuevo reporte con archivos jrxml y jasper
    public Reportesjr crearReporte(Short idrepoxopcion,
                                   String nomrep,
                                   String desrep,
                                   MultipartFile jrxml,
                                   MultipartFile jasper) throws JRException, IOException {
        Reportesjr reporte = new Reportesjr();
        reporte.setNomrep(nomrep);
        reporte.setDesrep(desrep);
        reporte.setJrxml(jrxml.getBytes());
        reporte.setJasper(jasper.getBytes());

        Repoxopcion repoxopcion = new Repoxopcion();
        repoxopcion.setIdrepoxopcion(idrepoxopcion);
        reporte.setRepoxopcion(repoxopcion);

        JasperReport jasperReport = JasperCompileManager.compileReport(new ByteArrayInputStream(jrxml.getBytes()));

        // reporte.setParametros(extraerParametros(jasperReport));

        // JasperReport jasperReport = JasperCompileManager.compileReport(new
        // ByteArrayInputStream(jrxml.getBytes()));
        JsonNode parametrosJson = construirParametrosJson(jasperReport);
        reporte.setParametros(parametrosJson);

        return dao.save(reporte);
    }

    // Actualizar solo campos sin archivos
    public Reportesjr actualizarSoloCampos(Short id,
                                           Short idrepoxopcion,
                                           String nomrep,
                                           String desrep) {
        Reportesjr reporte = dao.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("No existe el reporte con id " + id));

        reporte.setNomrep(nomrep);
        reporte.setDesrep(desrep);

        Repoxopcion repoxopcion = new Repoxopcion();
        repoxopcion.setIdrepoxopcion(idrepoxopcion);
        reporte.setRepoxopcion(repoxopcion);

        return dao.save(reporte);
    }

    // Actualizar solo archivos jrxml y jasper
    // public Reportesjr actualizarSoloArchivos(Short id,
    // MultipartFile jrxml,
    // MultipartFile jasper) throws JRException, IOException {
    // Reportesjr reporte = dao.findById(id)
    // .orElseThrow(() -> new EntityNotFoundException("No existe el reporte con id "
    // + id));

    // reporte.setJrxml(jrxml.getBytes());
    // reporte.setJasper(jasper.getBytes());

    // JasperReport jasperReport = JasperCompileManager.compileReport(new
    // ByteArrayInputStream(jrxml.getBytes()));
    // reporte.setParametros(extraerParametros(jasperReport));

    // return dao.save(reporte);
    // }

    // Actualizar todos los campos incluyendo archivos
    public Reportesjr actualizarCompleto(Short id,
                                         Short idrepoxopcion,
                                         String nomrep,
                                         String desrep,
                                         MultipartFile jrxml,
                                         MultipartFile jasper) throws JRException, IOException {
        Reportesjr reporte = dao.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("No existe el reporte con id " + id));
        // Metadatos
        reporte.setNomrep(nomrep);
        reporte.setDesrep(desrep);
        //reporte.setRepoxopcion(new Repoxopcion(idrepoxopcion));
        reporte.setRepoxopcion(new Repoxopcion());
        // Archivos
        reporte.setJrxml(jrxml.getBytes());
        reporte.setJasper(jasper.getBytes());

        JasperReport jasperReport = JasperCompileManager.compileReport(new ByteArrayInputStream(jrxml.getBytes()));

        // Map<String, Object> parametrosMap = extraerParametros(jasperReport);

        // 🔍 Verificación del orden en consola
        // System.out.println("Orden de parámetros extraídos:");
        // parametrosMap.forEach((k, v) -> System.out.println(k + " → " + v));

        // reporte.setParametros(extraerParametros(jasperReport));
        // JasperReport jasperReport = JasperCompileManager.compileReport(new
        // ByteArrayInputStream(jrxml.getBytes()));
        JsonNode parametrosJson = construirParametrosJson(jasperReport);
        reporte.setParametros(parametrosJson);

        return dao.save(reporte);
    }

    // Extrae los parámetros del JasperReport Usando JsonNode
    public JsonNode construirParametrosJson(JasperReport jasperReport) {
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode parametrosJson = mapper.createObjectNode();
        Arrays.stream(jasperReport.getParameters())
                .filter(p -> !p.isSystemDefined())
                .forEach(p -> {
                    String nombre = p.getName();
                    String tipo = p.getValueClassName();
                    String anchoCampo = Optional.ofNullable(p.getPropertiesMap().getProperty("anchoCampo")).orElse("12");
                    String orden = Optional.ofNullable(p.getPropertiesMap().getProperty("orden")).orElse("999");

                    parametrosJson.put(nombre, tipo + "|" + anchoCampo + "|" + orden);
                });
        return parametrosJson;
    }

    // Extrae los parámetros del JasperReport (ORDENADOS por | orden)
    // private Map<String, Object> extraerParametros(JasperReport jasperReport) {
    //    // Paso 1: filtrar y ordenar los parámetros por la propiedad 'orden'
    //    List<JRParameter> parametrosOrdenados = Arrays.stream(jasperReport.getParameters())
    //          .filter(p -> !p.isSystemDefined())
    //          .sorted(Comparator.comparingInt(p -> {
    //             String orden = p.getPropertiesMap().getProperty("orden");
    //             return orden != null ? Integer.parseInt(orden) : Integer.MAX_VALUE;
    //          }))
    //          .collect(Collectors.toList());

    //    // Paso 2: construir el LinkedHashMap respetando el orden
    //    Map<String, Object> parametrosMap = new LinkedHashMap<>();

    //    for (JRParameter param : parametrosOrdenados) {
    //       String nomvar = param.getName();
    //       String tipo = param.getValueClassName();
    //       JRPropertiesMap props = param.getPropertiesMap();

    //       String anchoCampo = Optional.ofNullable(props.getProperty("anchoCampo")).orElse("12");
    //       String orden = Optional.ofNullable(props.getProperty("orden")).orElse("999");

    //       parametrosMap.put(nomvar, tipo + "|" + anchoCampo + "|" + orden);
    //    }

    //    return parametrosMap;
    // }

    // Extrae los parámetros del JasperReport
    // private Map<String, Object> extraerParametrosOld1(JasperReport jasperReport) {
    //    List<JRParameter> parametrosOrdenados = Arrays.stream(jasperReport.getParameters())
    //          .filter(p -> !p.isSystemDefined())
    //          .sorted(Comparator.comparingInt(p -> {
    //             String orden = p.getPropertiesMap().getProperty("orden");
    //             return orden != null ? Integer.parseInt(orden) : Integer.MAX_VALUE;
    //          }))
    //          .collect(Collectors.toList());

    //    Map<String, Object> parametrosMap = new LinkedHashMap<>();

    //    for (JRParameter param : parametrosOrdenados) {
    //       String nomvar = param.getName();
    //       String tipo = param.getValueClassName();
    //       JRPropertiesMap props = param.getPropertiesMap();

    //       String anchoCampo = Optional.ofNullable(props.getProperty("anchoCampo")).orElse("12");
    //       String orden = Optional.ofNullable(props.getProperty("orden")).orElse("999");

    //       parametrosMap.put(nomvar, tipo + "|" + anchoCampo + "|" + orden);
    //    }
    //    return parametrosMap;
    // }

    // Extrae los parámetros del JasperReport
    // private Map<String, Object> extraerParametrosOld(JasperReport jasperReport) {

    //    List<JRParameter> parametrosOrdenados = Arrays.stream(jasperReport.getParameters())
    //          .filter(p -> !p.isSystemDefined())
    //          .sorted(Comparator.comparingInt(p -> {
    //             String orden = p.getPropertiesMap().getProperty("orden");
    //             return orden != null ? Integer.parseInt(orden) : Integer.MAX_VALUE;
    //          }))
    //          .collect(Collectors.toList());

    //    Map<String, Object> parametrosMap = new LinkedHashMap<>();

    //    // for (JRParameter param : jasperReport.getParameters()) {
    //    for (JRParameter param : parametrosOrdenados) {
    //       if (!param.isSystemDefined()) {
    //          String nomvar = param.getName();
    //          String tipo = param.getValueClassName();
    //          JRPropertiesMap props = param.getPropertiesMap();
    //          String anchoCampo = Optional.ofNullable(props.getProperty("anchoCampo")).orElse("12");
    //          String orden = Optional.ofNullable(props.getProperty("orden")).orElse("999");
    //          parametrosMap.put(nomvar, tipo + "|" + anchoCampo + "|" + orden);
    //       }
    //    }
    //    return parametrosMap;
    // }

    // private Map<String, Object> extraerParametrosOld(JasperReport jasperReport) {
    // Map<String, Object> parametrosMap = new LinkedHashMap<>();
    // for (JRParameter param : jasperReport.getParameters()) {
    // if (!param.isSystemDefined()) {
    // String nomvar = param.getName();
    // String tipo = param.getValueClassName();
    // String anchoCampo =
    // Optional.ofNullable(param.getPropertiesMap().getProperty("anchoCampo")).orElse("12");
    // parametrosMap.put(nomvar, tipo + "|" + anchoCampo);
    // }
    // }
    // return parametrosMap;
    // }

    // Busca un reportejr por ID
    public Optional<Reportesjr> buscaPorId(Short id) {
        return dao.findById(id);
    }

    public Reportesjr findByNomrep(String nomrep) {
        return dao.findByNomrep(nomrep);
    }

    public void deleteById(Short idreporte) {
        dao.deleteById(idreporte);
    }

}

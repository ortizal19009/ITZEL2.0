package com.itzel.jasperReports.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itzel.jasperReports.modelo.Reportes;
import com.itzel.jasperReports.repositories.ReportesR;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReporteService {

        private final ReportesR repository;
        private final ObjectMapper objectMapper;

        public ReporteService(ReportesR repository, ObjectMapper objectMapper) {
            this.repository = repository;
            this.objectMapper = objectMapper;
        }

        public Reportes saveReporte(String nombre,
                                    String descripcion,
                                    MultipartFile jrxmlFile,
                                    MultipartFile jasperFile) throws Exception {

            Reportes reporte = new Reportes();
            reporte.setNombre(nombre);
            reporte.setDescripcion(descripcion);

            if (jrxmlFile != null && !jrxmlFile.isEmpty()) {
                reporte.setArchivoJrxml(jrxmlFile.getBytes());
            }

            if (jasperFile != null && !jasperFile.isEmpty()) {
                reporte.setArchivoJasper(jasperFile.getBytes());

                // Extraer parámetros del jasper
                JasperReport jasperReport = (JasperReport) JRLoader.loadObject(
                        new ByteArrayInputStream(jasperFile.getBytes())
                );

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
            }

            return repository.save(reporte);
        }
    }

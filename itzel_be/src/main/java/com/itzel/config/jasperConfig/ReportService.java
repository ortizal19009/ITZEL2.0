package com.itzel.config.jasperConfig;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.stereotype.Service;

import java.io.*;

@Service
public class JasperReportService {
    public byte[] generarReporte(String reportName) throws JRException {
        // Cargar el archivo .jasper
        InputStream reportStream = getClass().getResourceAsStream("/reports/" +reportName+".jasper");
        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportStream);

        // Datos del reporte
       // List<Empleado> datos = obtenerDatos();
        //JRDataSource dataSource = new JRBeanCollectionDataSource(datos);

        // Parámetros (opcional)
        // Map<String, Object> parametros = new HashMap<>();
        // parametros.put("titulo", "Reporte de Empleados");

        // Llenar el reporte
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null);

        // Exportar a PDF
        return JasperExportManager.exportReportToPdf(jasperPrint);
    }
}

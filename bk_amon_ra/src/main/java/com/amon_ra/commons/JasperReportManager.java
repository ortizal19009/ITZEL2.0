package com.amon_ra.commons;

import net.sf.jasperreports.engine.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;
/**
 * @author <a href="mailto:4softwaredevelopers@gmail.com">Jordy Rodríguezr</a>
 * @project demo-spring-boot-jasper
 * @class JasperComponent
 * @description
 * @HU_CU_REQ
 * @date 17 sep. 2021
 */

@Component
public class JasperReportManager {
    private static final String REPORT_FOLDER = "jasperReport";
    private static final String JASPER = ".jrxml";
    /**
     * @param fileName
     * @param params
     * @return
     * @throws JRException
     * @throws IOException
     * @throws SQLException
     */

    public ByteArrayOutputStream export(String fileName, Map<String, Object> params, Connection con) throws JRException, IOException, SQLException {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        ClassPathResource resource = new ClassPathResource(REPORT_FOLDER + File.separator + fileName + JASPER);

        // Verifica la conexión a la base de datos
        if (con == null || con.isClosed()) {
            throw new SQLException("Conexión de base de datos no válida o cerrada.");
        }

        // Verifica si el archivo existe
        if (!resource.exists()) {
            throw new FileNotFoundException("No se encontró el archivo Jasper en: " + resource.getPath());
        }

        // Maneja el InputStream usando try-with-resources
        try (InputStream inputStream = resource.getInputStream()) {
            System.out.println("Cargando archivo Jasper desde: " + resource.getPath());
            //JasperCompileManager.compileReportToFile(inputStream);
            JasperPrint jasperPrint = JasperFillManager.fillReport(inputStream, params, con);
            System.out.println("Objeto JasperPrint generado correctamente: " + jasperPrint);
            JasperExportManager.exportReportToPdfStream(jasperPrint, stream);
        } catch (JRException e) {
            System.err.println("Error al generar el informe Jasper: " + e.getMessage());
            throw e;
        } catch (IOException e) {
            System.err.println("Error al cargar el archivo Jasper: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("Error inesperado: " + e.getMessage());
            throw new RuntimeException("Error inesperado al exportar el informe.", e);
        }
        return stream;
    }


}



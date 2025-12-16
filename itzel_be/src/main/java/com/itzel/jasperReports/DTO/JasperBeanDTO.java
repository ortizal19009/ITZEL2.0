package com.itzel.jasperReports.DTO;

import lombok.Data;

import java.util.List;

// DTO para reportes método 2: Colección de Beans
@Data
public class JasperBeanDTO {

    private String reportName; // Nombre del archivo jasper sin extensión
    private String extension; // pdf, xlsx, csv
    private List<ReportParameterDTO> parameters; // Parámetros del reporte
    private List<?> beanCollection;

}

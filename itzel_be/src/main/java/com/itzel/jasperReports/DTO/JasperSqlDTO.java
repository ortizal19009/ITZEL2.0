package com.itzel.jasperReports.DTO;

import lombok.Data;

import java.util.List;

@Data
public class JasperSqlDTO {

    private String reportName; // Nombre del archivo jasper sin extensión
    private String extension; // pdf, xlsx, csv
    private List<ReportParameterDTO> parameters; // Parámetros del reporte

}

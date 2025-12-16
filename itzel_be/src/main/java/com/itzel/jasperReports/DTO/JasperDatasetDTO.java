package com.itzel.jasperReports.DTO;

import lombok.Data;

import java.util.List;

@Data
public class JasperDatasetDTO<T> {

    private String reportName;
    private String extension;
    private List<ReportParameterDTO> parameters; // opcional
    // private List<?> data;
    private List<T> data;

}
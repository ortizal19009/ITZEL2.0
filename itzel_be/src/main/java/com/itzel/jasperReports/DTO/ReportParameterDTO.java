package com.itzel.jasperReports.DTO;

import lombok.Data;

@Data
public class ReportParameterDTO {
    private String name;   // nombre del parámetro
    private String type;   // tipo de dato (String, Integer, Date, etc.)
    private Object value;  // valor del parámetro
}
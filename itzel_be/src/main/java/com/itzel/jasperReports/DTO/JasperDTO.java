package com.itzel.jasperReports.DTO;
import lombok.Data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
public class JasperDTO {
    private String reportName;

    private List<ReportParameterDTOant> parameters;
    private String extension;

    public Long getReporteId() {
        return reporteId;
    }

    public void setReporteId(Long reporteId) {
        this.reporteId = reporteId;
    }

    private Long reporteId;

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public List<ReportParameterDTOant> getParameters() {
        return parameters;
    }

    public void setParameters(List<ReportParameterDTOant> parameters) {
        this.parameters = parameters;
    }

}
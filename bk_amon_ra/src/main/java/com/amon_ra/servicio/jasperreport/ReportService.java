package com.amon_ra.servicio.jasperreport;

import net.sf.jasperreports.engine.*;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.Map;

@Service
public class ReportService {
    public byte [] generarReportes(String reportName) throws JRException{
        InputStream reportStream = this.getClass().getResourceAsStream("/jasperReport/"+reportName+".jasper");
        Map<String, Object> params = null;
        JasperPrint reportPrint = JasperFillManager.fillReport(reportStream, params, new JREmptyDataSource());
        return JasperExportManager.exportReportToPdf(reportPrint);
    }
}

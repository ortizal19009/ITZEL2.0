package com.itzel.config.jasperConfig;

import com.itzel.commons.JasperReportManager;
import net.sf.jasperreports.engine.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@Service
public class JasperReportService {
    public byte[] generarReporte(String reportName) throws JRException {
        //Cargar el reporte
        InputStream reportStream = this.getClass().getResourceAsStream("/jasperReport/"+reportName+".jasper");
        Map<String, Object> params = null;
        JasperPrint jasperPrint = JasperFillManager.fillReport(reportStream, params, new JREmptyDataSource());
        return JasperExportManager.exportReportToPdf(jasperPrint);
    }
}

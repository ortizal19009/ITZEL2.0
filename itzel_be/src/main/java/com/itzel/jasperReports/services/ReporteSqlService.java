package com.itzel.jasperReports.services;

import com.itzel.jasperReports.DTO.JasperSqlDTO;
import com.itzel.jasperReports.DTO.ReportParameterDTO;
import com.itzel.jasperReports.modelo.Reportesjr;
import lombok.RequiredArgsConstructor;

import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleWriterExporterOutput;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class ReporteSqlService {

    private final ReportejrService repojrService; // Servicio que busca Reportesjr por nombre

    private final DataSource dataSource;

    public JasperPrint fillSqlReport(JasperSqlDTO dto) throws Exception {

        Reportesjr reporte = repojrService.findByNomrep(dto.getReportName());

        Map<String, Object> params = convertParams(dto.getParameters());

        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(
                new ByteArrayInputStream(reporte.getJasper()));

        try (Connection conn = dataSource.getConnection()) {
            return JasperFillManager.fillReport(jasperReport, params, conn);
        }
    }

    public ByteArrayOutputStream export(String ext, JasperPrint print) throws JRException {

        ByteArrayOutputStream out = new ByteArrayOutputStream();

        switch (ext.toLowerCase()) {
            case "pdf":
                JasperExportManager.exportReportToPdfStream(print, out);
                break;

            case "xlsx":
                JRXlsxExporter xlsx = new JRXlsxExporter();
                xlsx.setExporterInput(new SimpleExporterInput(print));
                xlsx.setExporterOutput(new SimpleOutputStreamExporterOutput(out));
                xlsx.exportReport();
                break;

            case "csv":
                JRCsvExporter csv = new JRCsvExporter();
                csv.setExporterInput(new SimpleExporterInput(print));
                csv.setExporterOutput(new SimpleWriterExporterOutput(out));
                csv.exportReport();
                break;
        }
        return out;
    }

    private Map<String, Object> convertParams(List<ReportParameterDTO> list) {
        Map<String, Object> map = new HashMap<>();
        if (list == null)
            return map;

        for (ReportParameterDTO p : list) {
            map.put(p.getName(), p.getValue());
        }
        return map;
    }

}
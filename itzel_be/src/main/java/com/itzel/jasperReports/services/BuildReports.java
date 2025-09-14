package com.itzel.jasperReports.services;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.SQLException;

import com.itzel.jasperReports.DTO.JasperDTO;
import com.itzel.jasperReports.modelo.Reportes;
import com.itzel.jasperReports.repositories.ReportesR;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;

@Service
public class BuildReports {
    @Autowired
    private ReportesR repo;
    @Autowired
    private ReporteService reportesService;
    @Autowired
    private DataSource dataSource; // Para la conexión a la DB
    // PDF
    public ByteArrayOutputStream buildPdfReport(JasperDTO dto, Connection conn) throws JRException {
        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/" + dto.getReportName() + ".jrxml")
        );
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
        return outputStream;
    }

    // XLSX
    public ByteArrayOutputStream buildXlsxReport(JasperDTO dto, Connection conn) throws JRException {
        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/" + dto.getReportName() + ".jrxml")
        );
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        JRXlsxExporter exporter = new JRXlsxExporter();

        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));

        SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
        configuration.setDetectCellType(true);   // Detecta tipo de celda
        configuration.setCollapseRowSpan(false);
        exporter.setConfiguration(configuration);

        exporter.exportReport();
        return outputStream;
    }

    // CSV
    public ByteArrayOutputStream buildCsvReport(JasperDTO dto, Connection conn) throws JRException {
        JasperReport jasperReport = JasperCompileManager.compileReport(
                getClass().getResourceAsStream("/reports/" + dto.getReportName() + ".jrxml")
        );
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        Writer writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);

        JRCsvExporter exporter = new JRCsvExporter();
        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleWriterExporterOutput(writer));

        SimpleCsvExporterConfiguration configuration = new SimpleCsvExporterConfiguration();
        exporter.setConfiguration(configuration);

        exporter.exportReport();
        return outputStream;
    }

    //Reportes desde base de datos

    public Reportes buscarPorId(Long id) {
        return repo.findById(id)
                .orElseThrow(() -> new RuntimeException("Reporte no encontrado"));
    }

    private Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public ByteArrayOutputStream _buildPdfReport(Long reporteId) throws JRException, SQLException {
        Reportes reporte = buscarPorId(reporteId);
        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
            return outputStream;
        }
    }

    public ByteArrayOutputStream _buildXlsxReport(Long reporteId) throws JRException, SQLException {
        Reportes reporte = buscarPorId(reporteId);
        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            JRXlsxExporter exporter = new JRXlsxExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));

            SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
            configuration.setDetectCellType(true);
            configuration.setCollapseRowSpan(false);
            exporter.setConfiguration(configuration);
            exporter.exportReport();

            return outputStream;
        }
    }

    public ByteArrayOutputStream _buildCsvReport(Long reporteId) throws JRException, SQLException {
        Reportes reporte = buscarPorId(reporteId);
        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            Writer writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);

            JRCsvExporter exporter = new JRCsvExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleWriterExporterOutput(writer));

            SimpleCsvExporterConfiguration configuration = new SimpleCsvExporterConfiguration();
            exporter.setConfiguration(configuration);
            exporter.exportReport();

            return outputStream;
        }
    }


    // PDF
    public ByteArrayOutputStream buildPdfReport(JasperDTO dto) throws JRException, SQLException {
        Reportes reporte = reportesService.findByNombre(dto.getReportName());

        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
            return outputStream;
        }
    }

    // XLSX
    public ByteArrayOutputStream buildXlsxReport(JasperDTO dto) throws JRException, SQLException {
        Reportes reporte = reportesService.findByNombre(dto.getReportName());
        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            JRXlsxExporter exporter = new JRXlsxExporter();

            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));

            SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
            configuration.setDetectCellType(true);
            configuration.setCollapseRowSpan(false);
            exporter.setConfiguration(configuration);

            exporter.exportReport();
            return outputStream;
        }
    }

    // CSV
    public ByteArrayOutputStream buildCsvReport(JasperDTO dto) throws JRException, SQLException {
        Reportes reporte = reportesService.findByNombre(dto.getReportName());
        try (Connection conn = getConnection()) {
            JasperReport jasperReport = JasperCompileManager.compileReport(
                    new ByteArrayInputStream(reporte.getArchivoJrxml())
            );

            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, dto.getParameters(), conn);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            Writer writer = new OutputStreamWriter(outputStream, StandardCharsets.UTF_8);

            JRCsvExporter exporter = new JRCsvExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleWriterExporterOutput(writer));

            SimpleCsvExporterConfiguration configuration = new SimpleCsvExporterConfiguration();
            exporter.setConfiguration(configuration);

            exporter.exportReport();
            return outputStream;
        }
    }
}

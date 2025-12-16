package com.itzel.jasperReports.controllers;


import com.itzel.jasperReports.DTO.JasperDTO;
import com.itzel.jasperReports.services.BuildReports;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.sql.SQLException;

@RequiredArgsConstructor
@RestController
@RequestMapping("/jasperReports")
@CrossOrigin("*")
public class BuildReportsApi {

    private final BuildReports buildReports;

    @GetMapping("/reportes")
    public ResponseEntity<String> reportesGetNotAllowed() {
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED)
                .body("El método GET no está permitido en este endpoint. Usa POST.");
    }

    // === REPORTES DESDE BASE DE DATOS ===

    @PostMapping("/{id}/pdf")
    public ResponseEntity<byte[]> descargarPdf(@RequestBody JasperDTO jasperDTO) throws JRException, SQLException {
        ByteArrayOutputStream outputStream = buildReports.buildPdfReport(jasperDTO);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=reporte.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(outputStream.toByteArray());
    }

    @PostMapping("/{id}/xlsx")
    public ResponseEntity<byte[]> descargarXlsx(@RequestBody JasperDTO jasperDTO) throws JRException, SQLException {
        ByteArrayOutputStream outputStream = buildReports.buildXlsxReport(jasperDTO);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=reporte.xlsx")
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(outputStream.toByteArray());
    }

    @PostMapping("/{id}/csv")
    public ResponseEntity<byte[]> descargarCsv(@RequestBody JasperDTO jasperDTO) throws JRException, SQLException {
        ByteArrayOutputStream outputStream = buildReports.buildCsvReport(jasperDTO);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=reporte.csv")
                .contentType(MediaType.TEXT_PLAIN)
                .body(outputStream.toByteArray());
    }

    @PostMapping("/descargar")
    public ResponseEntity<byte[]> descargarReporte(@RequestBody JasperDTO jasperDTO) {
        try {
            ByteArrayOutputStream outputStream;
            String filename;
            MediaType mediaType;

            // Genera el reporte; el servicio se encarga de la conversión de parámetros
            switch (jasperDTO.getExtension().toLowerCase()) {
                case "pdf":
                    outputStream = buildReports.buildPdfReport(jasperDTO);
                    filename = jasperDTO.getReportName() + ".pdf";
                    mediaType = MediaType.APPLICATION_PDF;
                    break;
                case "xlsx":
                    outputStream = buildReports.buildXlsxReport(jasperDTO);
                    filename = jasperDTO.getReportName() + ".xlsx";
                    mediaType = MediaType.parseMediaType(
                            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                    break;
                case "csv":
                    outputStream = buildReports.buildCsvReport(jasperDTO);
                    filename = jasperDTO.getReportName() + ".csv";
                    mediaType = MediaType.TEXT_PLAIN;
                    break;
                default:
                    return ResponseEntity.badRequest().build();
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                    .contentType(mediaType)
                    .body(outputStream.toByteArray());

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
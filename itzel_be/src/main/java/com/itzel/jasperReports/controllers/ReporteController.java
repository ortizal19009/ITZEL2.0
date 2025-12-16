package com.itzel.jasperReports.controllers;


import com.itzel.jasperReports.DTO.JasperBeanDTO;
import com.itzel.jasperReports.services.ReporteBeanService;
import com.itzel.jasperReports.services.ReporteExportService;
import com.itzel.jasperReports.services.ReporteSqlService;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JasperPrint;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;

@RequiredArgsConstructor
@RestController
@RequestMapping("/reporteJasper")
@CrossOrigin("*")

public class ReporteController {

    // Servicio para SQL Directo
    private final ReporteSqlService reporteSqlService;

    // Servicio para Beans
    private final ReporteBeanService reporteBeanService;

    // Servicio para Dataset
    // private final ReporteDatasetService reporteDatasetService;

    private final ReporteExportService exportService;

    // ========== SQL DIRECTO ==========
    @PostMapping("/sql")
    public ResponseEntity<byte[]> descargarSql(@RequestBody JasperSqlDTO dto) {
        try {
            JasperPrint print = reporteSqlService.fillSqlReport(dto);
            ByteArrayOutputStream stream = exportService.export(dto.getExtension(), print);
            return buildResponse(dto.getReportName(), dto.getExtension(), stream);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // === BEAN COLLECTION (No se usa se llama desde la API de cada opcion)
    @PostMapping("/beans")
    public ResponseEntity<byte[]> descargarBeans(@RequestBody JasperBeanDTO dto) {
        try {
            JasperPrint print = reporteBeanService.fillBeanReport(dto);
            ByteArrayOutputStream stream = exportService.export(dto.getExtension(), print);
            return buildResponse(dto.getReportName(), dto.getExtension(), stream);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // @PostMapping("/dataset")
    // public ResponseEntity<byte[]> generarReporteDesdeDataset(@RequestBody JasperDatasetDTO dto) {
    //    try {

    //       byte[] reporteBytes = reporteDatasetService.generarReporte(dto);

    //       HttpHeaders headers = new HttpHeaders();
    //       headers.setContentType(getMediaType(dto.getExtension()));
    //       headers.setContentDisposition(ContentDisposition.builder("inline")
    //             .filename(dto.getReportName() + "." + dto.getExtension())
    //             .build());

    //       return new ResponseEntity<>(reporteBytes, headers, HttpStatus.OK);

    //    } catch (Exception e) {
    //       e.printStackTrace();
    //       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    //    }
    // }

    private ResponseEntity<byte[]> buildResponse(String name, String ext, ByteArrayOutputStream stream) {

        MediaType mediaType;

        switch (ext.toLowerCase()) {
            case "pdf":
                mediaType = MediaType.APPLICATION_PDF;
                break;
            case "xlsx":
                mediaType = MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                break;
            case "csv":
                mediaType = MediaType.TEXT_PLAIN;
                break;
            default:
                mediaType = MediaType.APPLICATION_OCTET_STREAM;
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + name + "." + ext)
                .contentType(mediaType)
                .body(stream.toByteArray());
    }

    // private MediaType getMediaType(String extension) {
    //    if (extension == null)
    //       return MediaType.APPLICATION_OCTET_STREAM;

    //    switch (extension.toLowerCase()) {
    //       case "pdf":
    //          return MediaType.APPLICATION_PDF;
    //       case "xlsx":
    //          // application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    //          return MediaType.parseMediaType(
    //                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    //       case "xls":
    //          return MediaType.parseMediaType("application/vnd.ms-excel");
    //       case "docx":
    //          // application/vnd.openxmlformats-officedocument.wordprocessingml.document
    //          return MediaType.parseMediaType(
    //                "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    //       case "csv":
    //          return MediaType.parseMediaType("text/csv");
    //       case "html":
    //          return MediaType.TEXT_HTML;
    //       case "rtf":
    //          return MediaType.parseMediaType("application/rtf");
    //       case "xml":
    //          return MediaType.APPLICATION_XML;
    //       case "json":
    //          return MediaType.APPLICATION_JSON;
    //       default:
    //          // Fallback genérico
    //          return MediaType.APPLICATION_OCTET_STREAM;
    //    }
    // }

}

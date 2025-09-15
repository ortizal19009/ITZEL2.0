package com.itzel.jasperReports.controllers;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.itzel.jasperReports.DTO.JasperDTO;
import com.itzel.jasperReports.services.BuildReports;

@RestController
@RequestMapping("/jasperReports")
@CrossOrigin("*")
public class BuildReportsApi {
    @Autowired
    private BuildReports buildReports;
    @Autowired
    private DataSource dataSource;

    @GetMapping("/reportes")
    public ResponseEntity<String> reportesGetNotAllowed() {
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED)
                .body("El método GET no está permitido en este endpoint. Usa POST.");
    }

    @PostMapping("/reportes")
    public ResponseEntity<Resource> generarReporte(@RequestBody JasperDTO jasperDTO) {
        try {
            JasperDTO dto = new JasperDTO();
            dto.setReportName(jasperDTO.getReportName());
            dto.setExtension(jasperDTO.getExtension());

            Map<String, Object> params = new HashMap<>();

            for (Map.Entry<String, Object> entry : jasperDTO.getParameters().entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                if (value == null) continue;

                if ("desde".equalsIgnoreCase(key) || "hasta".equalsIgnoreCase(key) || "tope".equalsIgnoreCase(key)) {
                    params.put(key, parseDateToSQLType(value.toString()));
                } else if ("hdesde".equalsIgnoreCase(key) || "hhasta".equalsIgnoreCase(key)) {
                    params.put(key, parseToSqlTime(value.toString()));
                } else {
                    params.put(key, normalizeParameterValue(key, value));
                }
            }

            dto.setParameters(params);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            try (Connection conn = dataSource.getConnection()) {
                if (".xlsx".equalsIgnoreCase(dto.getExtension())) {
                    outputStream = buildReports.buildXlsxReport(dto, conn);
                } else if (".csv".equalsIgnoreCase(dto.getExtension())) {
                    outputStream = buildReports.buildCsvReport(dto, conn);
                } else { // por defecto PDF
                    outputStream = buildReports.buildPdfReport(dto, conn);
                }
            }

            ByteArrayInputStream inputStream = new ByteArrayInputStream(outputStream.toByteArray());
            InputStreamResource resource = new InputStreamResource(inputStream);

            String fileName = jasperDTO.getReportName() + jasperDTO.getExtension();
            MediaType mediaType;

            switch (dto.getExtension().toLowerCase()) {
                case ".xlsx":
                    mediaType = MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                    break;
                case ".csv":
                    mediaType = MediaType.parseMediaType("text/csv");
                    break;
                default:
                    mediaType = MediaType.APPLICATION_PDF;
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName)
                    .contentType(mediaType)
                    .contentLength(outputStream.size())
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    private Object parseDateToSQLType(String value) throws ParseException {
        String[] formats = {
                "yyyy-MM-dd HH:mm:ss",
                "yyyy-MM-dd HH:mm",
                "yyyy-MM-dd"
        };

        for (String format : formats) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(format);
                sdf.setLenient(false);
                Date parsed = sdf.parse(value.trim());
                if (format.contains("HH")) {
                    return new java.sql.Timestamp(parsed.getTime());
                } else {
                    return new java.sql.Date(parsed.getTime());
                }
            } catch (ParseException ignored) {
            }
        }

        throw new IllegalArgumentException("Fecha inválida: " + value);
    }

    private java.sql.Time parseToSqlTime(String timeStr) {
        if (timeStr == null || timeStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Time string cannot be null or empty");
        }

        String[] formats = {
                "HH:mm:ss",
                "HH:mm"
        };

        for (String format : formats) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(format);
                sdf.setLenient(false);
                Date parsed = sdf.parse(timeStr.trim());
                return new java.sql.Time(parsed.getTime());
            } catch (ParseException e) {
                // Try next format
            }
        }

        throw new IllegalArgumentException("Invalid time format: '" + timeStr +
                "'. Expected formats: HH:mm:ss or HH:mm");
    }

    private Object normalizeParameterValue(String key, Object value) {
        if (value instanceof Integer) {
            return value;
        } else if (value instanceof Long) {
            Long longVal = (Long) value;
            if (longVal >= Integer.MIN_VALUE && longVal <= Integer.MAX_VALUE) {
                return longVal.intValue();
            } else {
                throw new IllegalArgumentException("El valor Long excede el rango de Integer");
            }
        } else if (value instanceof java.util.Date) {
            return value; // Devuelve la fecha tal cual
        } else if (value instanceof String) {
            // 🔥 Mantener como String, no convertir a Integer
            return value;
        }
        return value;
    }

    //REPORTES DESDE BASE DE DATOS



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

    //Este post tiene integrado todos los archivos de acuerdo con la extencion que el fron envie
    @PostMapping("/descargar")
    public ResponseEntity<byte[]> descargarReporte(@RequestBody JasperDTO jasperDTO) throws JRException, SQLException {
        ByteArrayOutputStream outputStream;
        String filename;
        MediaType mediaType;
        switch (jasperDTO.getExtension().toLowerCase()) {
            case "pdf":
                outputStream = buildReports.buildPdfReport(jasperDTO);
                filename = "reporte.pdf";
                mediaType = MediaType.APPLICATION_PDF;
                break;

            case "xlsx":
                outputStream = buildReports.buildXlsxReport(jasperDTO);
                filename = "reporte.xlsx";
                mediaType = MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                break;

            case "csv":
                outputStream = buildReports.buildCsvReport(jasperDTO);
                filename = "reporte.csv";
                mediaType = MediaType.TEXT_PLAIN;
                break;

            default:
                return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                .contentType(mediaType)
                .body(outputStream.toByteArray());
    }


}

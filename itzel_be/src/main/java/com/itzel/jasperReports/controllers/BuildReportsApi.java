package com.itzel.jasperReports.controllers;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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
            dto.setExtencion(jasperDTO.getExtencion());

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
                if (".xlsx".equalsIgnoreCase(dto.getExtencion())) {
                    outputStream = buildReports.buildXlsxReport(dto, conn);
                } else if (".csv".equalsIgnoreCase(dto.getExtencion())) {
                    outputStream = buildReports.buildCsvReport(dto, conn);
                } else { // por defecto PDF
                    outputStream = buildReports.buildPdfReport(dto, conn);
                }
            }

            ByteArrayInputStream inputStream = new ByteArrayInputStream(outputStream.toByteArray());
            InputStreamResource resource = new InputStreamResource(inputStream);

            String fileName = jasperDTO.getReportName() + jasperDTO.getExtencion();
            MediaType mediaType;

            switch (dto.getExtencion().toLowerCase()) {
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


    private Object _normalizeParameterValue(String key, Object value) {
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
            try {
                Integer intVal = Integer.valueOf((String) value);
                return intVal;
            } catch (NumberFormatException e) {
                return value; // o lanza excepción si sabes que debe ser Integer
            }
        }
        return value;
    }

    @PostMapping("/comprobante")
    public ResponseEntity<String> imprimirPDF(@RequestParam("pdf") MultipartFile pdfFile) {
        try {
            // Guardar archivo temporal
            File tempFile = File.createTempFile("comprobante_", ".pdf");
            pdfFile.transferTo(tempFile);

            // Llamar función de impresión
            imprimirArchivoPDF(tempFile);

            return ResponseEntity.ok("Impresión enviada correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error al imprimir: " + e.getMessage());
        }
    }

    private void imprimirArchivoPDF(File pdf) throws IOException {
        String os = System.getProperty("os.name").toLowerCase();

        if (os.contains("win")) {
            // Windows: usar comando nativo para imprimir
            String comando = "cmd /c start /min acrord32 /p /h \"" + pdf.getAbsolutePath() + "\"";
            Runtime.getRuntime().exec(comando);
        } else {
            // Linux o macOS: usar lpr
            String[] comando = { "lp", "-d", "nombre_impresora", pdf.getAbsolutePath() };
            Process process = new ProcessBuilder(comando).start();
        }
    }
}

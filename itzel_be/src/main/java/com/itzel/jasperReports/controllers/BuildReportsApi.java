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

    @PostMapping("/__reportes")
    public ResponseEntity<Resource> __generarPdfFactura(@RequestBody JasperDTO jasperDTO) {
        try {
            // Creamos un nuevo DTO donde meteremos valores ya convertidos
            JasperDTO dto = new JasperDTO();
            dto.setReportName(jasperDTO.getReportName());

            // Formato para parsear cadenas “yyyy-MM-dd” a java.sql.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Recorremos cada par <clave, valor> que nos llegó en el JSON
            for (Entry<String, Object> entry : jasperDTO.getParameters().entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                  // Si la clave es “desde” o “hasta”, asumimos que viene como String “yyyy-MM-dd”
                if ("desde".equals(key) || "hasta".equals(key) || "tope".equals(key)) {
                    try {
                        // Primero intentamos parsear como fecha con hora (formato completo)
                        String[] dateFormats = {
                                "yyyy-MM-dd HH:mm:ss", // Formato con hora completa
                                "yyyy-MM-dd HH:mm", // Formato con hora y minutos
                                "yyyy-MM-dd" // Formato solo fecha
                        };

                        java.util.Date parsed = null;
                        ParseException lastException = null;
                        // Intentamos con cada formato hasta que uno funcione
                        for (String format : dateFormats) {
                            try {
                                SimpleDateFormat tempFormat = new SimpleDateFormat(format);
                                tempFormat.setLenient(false); // Validación estricta
                                parsed = tempFormat.parse(value.toString());
                                break; // Si tiene éxito, salimos del bucle
                            } catch (ParseException e) {
                                lastException = e;
                            }
                        }

                        if (parsed == null) {
                            throw new IllegalArgumentException(
                                    "La fecha '" + value + "' no tiene un formato válido. " +
                                            "Formatos aceptados: yyyy-MM-dd, yyyy-MM-dd HH:mm, yyyy-MM-dd HH:mm:ss",
                                    lastException);
                        }

                        // Almacenamos como java.sql.Timestamp si tiene hora, o java.sql.Date si es solo
                        // fecha
                        if (value.toString().trim().length() > 10) { // Tiene hora
                            dto.getParameters().put(key, new java.sql.Timestamp(parsed.getTime()));
                        } else {
                            dto.getParameters().put(key, new java.sql.Date(parsed.getTime()));
                        }

                    } catch (Exception e) {
                        throw new IllegalArgumentException("Error procesando fecha '" + value + "'", e);
                    }
                } else {
                    /*
                     * Para cualquier otro parámetro numérico (por ejemplo un id), puede venir como:
                     * • Integer (189)
                     * • Long (189L)
                     * • String ("189")
                     *
                     * Lo normal para Jasper es que, si la consulta SQL espera un LONG,
                     * debemos convertirlo a Long en todos los casos.
                     */
                    if (value instanceof Integer) {
                        // de Integer a Long
                        // dto.getParameters().put(key, ((Integer) value).longValue());
                        dto.getParameters().put(key, (value));

                    } else if (value instanceof Long) {
                        dto.getParameters().put(key, (Long) value);
                    } else if (value instanceof String) {
                        // intentamos parsear el String a Long
                        try {
                            dto.getParameters().put(key, Long.valueOf((String) value));
                        } catch (NumberFormatException ex) {
                            throw new IllegalArgumentException("El parámetro '" + key +
                                    "' con valor '" + value + "' no es un Long válido", ex);
                        }
                    } else {
                        // Si fuese otro tipo (por ejemplo List<?> u Object), lo dejamos tal cual,
                        // o bien podrías lanzar un error indicando tipo no esperado.
                        dto.getParameters().put(key, value);
                    }
                }
            }

            // Ahora invocamos a buildReport pasándole la conexión y el dto ya “limpio”
            ByteArrayOutputStream pdfStream;
            try (Connection conn = dataSource.getConnection()) {
                pdfStream = buildReports.buildReport(dto, conn);
            }

            // Envolvemos el resultado en un Resource para devolverlo al cliente
            InputStreamResource resource = new InputStreamResource(
                    new ByteArrayInputStream(pdfStream.toByteArray()));

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=" + jasperDTO.getReportName() + ".pdf")
                    .contentType(MediaType.APPLICATION_PDF)
                    .contentLength(pdfStream.size())
                    .body(resource);

        } catch (Exception e) {
            // Aquí podrías registrar el error con un logger y devolver 500
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/reportes")
    public ResponseEntity<String> reportesGetNotAllowed() {
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED)
                .body("El método GET no está permitido en este endpoint. Usa POST.");
    }

    @PostMapping("/reportes")
    public ResponseEntity<Resource> generarPdfFactura(@RequestBody JasperDTO jasperDTO) {
        try {
            JasperDTO dto = new JasperDTO();
            dto.setReportName(jasperDTO.getReportName());

            Map<String, Object> params = new HashMap<>();

            for (Map.Entry<String, Object> entry : jasperDTO.getParameters().entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                if (value == null)
                    continue;

                if ("desde".equalsIgnoreCase(key) || "hasta".equalsIgnoreCase(key) || "tope".equalsIgnoreCase(key)) {
                    params.put(key, parseDateToSQLType(value.toString()));
                } else if ("hdesde".equalsIgnoreCase(key) || "hhasta".equalsIgnoreCase(key)) {
                    params.put(key, parseToSqlTime(value.toString()));
                } else {
                    params.put(key, normalizeParameterValue(key, value));
                }

            }

            dto.setParameters(params);

            ByteArrayOutputStream outputStream;
            try (Connection conn = dataSource.getConnection()) {
                outputStream = buildReports.buildReport(dto, conn);
            }

            ByteArrayInputStream pdfStream = new ByteArrayInputStream(outputStream.toByteArray());
            InputStreamResource resource = new InputStreamResource(pdfStream);

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=" + jasperDTO.getReportName() + ".pdf")
                    .contentType(MediaType.APPLICATION_PDF)
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

package com.amon_ra.config.jasperConfig;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.Map;

@Component
public class JasperReportManager {
    private static final Logger logger = LoggerFactory.getLogger(JasperReportManager.class);

    @Value("${report.folder:jasperReport}")
    private String reportFolder;

    private static final String JASPER = ".jasper";

    public ByteArrayOutputStream export(String fileName, Map<String, Object> params, Connection con)
            throws CustomReportException {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        if (fileName == null || fileName.isEmpty()) {
            throw new IllegalArgumentException("Report file name cannot be null or empty");
        }
        if (params == null) {
            throw new IllegalArgumentException("Parameters map cannot be null");
        }

        try (InputStream inputStream = new ClassPathResource(reportFolder + File.separator + fileName + JASPER).getInputStream()) {
            logger.info("Input stream for the report [{}] is ready.", fileName);
            JasperPrint jasperPrint = JasperFillManager.fillReport(inputStream, params, con);
            JasperExportManager.exportReportToPdfStream(jasperPrint, stream);
            logger.info("Report [{}] generated successfully.", fileName);
        } catch (JRException | IOException e) {
            logger.error("Error generating the report [{}]: {}", fileName, e.getMessage(), e);
            throw new CustomReportException("Error generating the report: " + fileName, e);
        }

        return stream;
    }

    public static class CustomReportException extends RuntimeException {
        public CustomReportException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}


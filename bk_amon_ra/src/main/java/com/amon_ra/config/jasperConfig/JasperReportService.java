package com.amon_ra.config.jasperConfig;

import net.sf.jasperreports.engine.JRException;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

@Service
public class JasperReportService implements JasperInterface {
    private static final Logger logger = LoggerFactory.getLogger(JasperReportService.class);

    @Autowired
    private JasperReportManager jasperReportManager;

    @Autowired
    private DataSource dataSource;

    @Override
    public ReportModelDTO GenerarReportes(Map<String, Object> params) throws CustomReportServiceException {
        String fileName = (String) params.get("fileName");
        if (fileName == null || fileName.isEmpty()) {
            throw new IllegalArgumentException("The parameter 'fileName' is required and cannot be null or empty.");
        }

        ReportModelDTO dto = new ReportModelDTO();
        dto.setFileName(fileName + ".pdf");

        try (Connection connection = dataSource.getConnection()) {
            ByteArrayOutputStream stream = jasperReportManager.export(fileName, params, connection);
            byte[] reportBytes = stream.toByteArray();
            dto.setStream(new ByteArrayInputStream(reportBytes));
            dto.setLength(reportBytes.length);

            logger.info("Report [{}] generated successfully. Size: {} bytes", fileName, reportBytes.length);
        } catch (SQLException e) {
            logger.error("Error generating report [{}]: {}", fileName, e.getMessage(), e);
            throw new CustomReportServiceException("Error generating report: " + fileName, e);
        }

        return dto;
    }

    public static class CustomReportServiceException extends RuntimeException {
        public CustomReportServiceException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}

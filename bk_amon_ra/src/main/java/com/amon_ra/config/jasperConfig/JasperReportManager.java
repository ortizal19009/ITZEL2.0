package com.amon_ra.config;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.Map;

@Component
public class JasperReportManager {
    private static final String REPORT_FOLDER = "reports";

    private static final String JASPER = ".jasper";
    public ByteArrayOutputStream export(String fileName, Map<String, Object> params,
                                        Connection con) throws JRException, IOException {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        ClassPathResource resource = new ClassPathResource(REPORT_FOLDER + File.separator + fileName + JASPER);
        InputStream inputStream = resource.getInputStream();
        JasperPrint jasperPrint = JasperFillManager.fillReport(inputStream, params, con);
		/* if (tipoReporte.equalsIgnoreCase(tipoReporte.toString())) {
			JRXlsxExporter exporter = new JRXlsxExporter();
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(stream));
			SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
			configuration.setDetectCellType(true);
			configuration.setCollapseRowSpan(true);
			exporter.setConfiguration(configuration);
			exporter.exportReport();
		} else {
		} */
        JasperExportManager.exportReportToPdfStream(jasperPrint, stream);

        return stream;
    }
}

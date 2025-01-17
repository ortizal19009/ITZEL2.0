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
    private static final String REPORT_FOLDER = "../jasperReport";
    private static final String JASPER = ".jasper";
    public ByteArrayOutputStream export(String fileName, Map<String, Object> params, Connection con) throws JRException, IOException{
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        ClassPathResource resource = new ClassPathResource(REPORT_FOLDER + File.separator + fileName + JASPER);
        System.out.println(resource.getInputStream());
        InputStream inputStream = resource.getInputStream();
        JasperPrint jasperPrint = JasperFillManager.fillReport(inputStream, params, con);
        JasperExportManager.exportReportToPdfStream(jasperPrint, stream);
        return stream;
    }
}


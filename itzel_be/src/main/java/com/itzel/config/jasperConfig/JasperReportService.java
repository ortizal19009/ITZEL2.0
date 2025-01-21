package com.itzel.config.jasperConfig;

import com.itzel.commons.JasperReportManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import net.sf.jasperreports.engine.JRException;

import javax.sql.DataSource;
import java.io.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@Service
public class JasperReportService implements JasperInterface {
    @Autowired
    private JasperReportManager jasperReportManager;

    @Autowired
    private DataSource dataSource;

    /**
     * @param params
     * @return
     * @throws SQLException
     * @throws IOException
     * @throws JRException
     * @see
     */

    @Override
    public ReportModelDTO GenerarReportes(Map<String, Object> params) throws JRException, IOException, SQLException {
        String fileName = params.get("fileName").toString();
        ReportModelDTO dto = new ReportModelDTO();
        dto.setFileName(fileName + ".pdf");
        ByteArrayOutputStream stream = jasperReportManager.export(fileName, params, dataSource.getConnection());
        byte[] bs = stream.toByteArray();
        dto.setStream(new ByteArrayInputStream(bs));
        dto.setLength(bs.length);
        return dto;
    }
}

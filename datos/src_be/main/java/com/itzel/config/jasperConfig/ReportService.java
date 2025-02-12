package com.itzel.config.jasperConfig;

import com.itzel.commons.ReportManager;
import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@Service
public class ReportService implements Report_i {
    @Autowired
    private ReportManager reportManager;

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
    public ReportDTO generateReport(Map<String, Object> params)
            throws JRException, IOException, SQLException {
        String fileName = params.get("fileName").toString();
        ReportDTO dto = new ReportDTO();
		/* String extension = params.get("tipo").toString().equalsIgnoreCase("EXCEL") ? ".xlsx"
				: ".pdf"; */
        dto.setFileName(fileName + ".pdf");

        ByteArrayOutputStream stream = reportManager.export(fileName, params,
                dataSource.getConnection());

        byte[] bs = stream.toByteArray();
        dto.setStream(new ByteArrayInputStream(bs));
        dto.setLength(bs.length);

        return dto;
    }
}


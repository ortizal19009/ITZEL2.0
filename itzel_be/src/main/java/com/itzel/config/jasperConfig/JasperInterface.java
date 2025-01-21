package com.itzel.config.jasperConfig;

import net.sf.jasperreports.engine.JRException;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

public interface JasperInterface {
    /**
     * @param params
     * @return
     */
    ReportModelDTO GenerarReportes(Map<String, Object> params) throws JRException, IOException, SQLException;
}

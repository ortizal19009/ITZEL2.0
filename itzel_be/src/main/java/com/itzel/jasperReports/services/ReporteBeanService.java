package com.itzel.jasperReports.services;

import com.itzel.jasperReports.DTO.JasperBeanDTO;
import com.itzel.jasperReports.modelo.Reportesjr;
import com.itzel.jasperReports.utils.ParamConverter;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class ReporteBeanService {

    private final ReportejrService repojrService; // Servicio que busca Reportesjr por nombre

    private final ParamConverter paramConverter;

    public JasperPrint fillBeanReport(JasperBeanDTO dto) throws Exception {

        // Obtiene el objeto Jasper (.jasper) desde la BD
        Reportesjr reporte = repojrService.findByNomrep(dto.getReportName());

        Map<String, Object> params = paramConverter.convert(dto.getParameters());

        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(dto.getBeanCollection());

        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(
                new ByteArrayInputStream(reporte.getJasper()));

        return JasperFillManager.fillReport(jasperReport, params, dataSource);
    }

}

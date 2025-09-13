package com.itzel.jasperReports.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itzel.jasperReports.modelo.Reportes;
import com.itzel.jasperReports.repositories.ReportesR;
import jakarta.transaction.Transactional;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.*;

@Service
public class ReporteService {
@Autowired
private ReportesR repo;
    public Reportes guardar(Reportes reporte) {
        if (repo.existsByNombre(reporte.getNombre())) {
            throw new RuntimeException("Ya existe un reporte con el nombre: " + reporte.getNombre());
        }
        return repo.save(reporte);
    }

    public List<Reportes> listarTodos() {
        return repo.findAll();
    }

    public Optional<Reportes> buscarPorId(Long id) {
        return repo.findById(id);
    }

    public void eliminar(Long id) {
        repo.deleteById(id);
    }

}

package com.itzel.jasperReports.services;

import com.itzel.jasperReports.modelo.Reportesjr;
import com.itzel.jasperReports.repositories.ReportesjrR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ReporteService {
@Autowired
private ReportesjrR repo;
    public Reportesjr guardar(Reportesjr reporte) {
        if (repo.existsByNombre(reporte.getNombre())) {
            throw new RuntimeException("Ya existe un reporte con el nombre: " + reporte.getNombre());
        }
        return repo.save(reporte);
    }

    public List<Reportesjr> listarTodos() {
        return repo.findAll();
    }

    public Optional<Reportesjr> buscarPorId(Long id) {
        return repo.findById(id);
    }
    public Reportesjr findByNombre(String nombre) {
        return repo.findByNombre(nombre);
    }


    public void eliminar(Long id) {
        repo.deleteById(id);
    }

}

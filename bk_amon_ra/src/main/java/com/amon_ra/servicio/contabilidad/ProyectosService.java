package com.amon_ra.servicio.contabilidad;

import com.amon_ra.modelo.contabilidad.Proyectos;
import com.amon_ra.repositorio.contabilidad.ProyectosR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ProyectosService {
    @Autowired
    private ProyectosR dao;

    public List<Proyectos> findAll(Sort sort){
        return dao.findAll(sort);
    }
    public Optional<Proyectos> findById(Long idestrfunc){
        return dao.findById(idestrfunc);
    }
    public Proyectos findByCodigo(String codigo){
        return dao.findByCodigo(codigo);
    }
    public Proyectos findByNombre(String nombre){
        return dao.findByNombre(nombre);
    }
    public Map<String, Object> save(Proyectos e) {
        Map<String, Object> response = new HashMap<>();
        if (e == null || e.getCodigo() == null || e.getIdestructura_estructura() == null) {
            response.put("status", "error");
            response.put("message", "Dato de ingreso invalido.");
            return response;
        }
        Long codigoLength = (long) e.getCodigo().length();
        Long expectedLength = e.getIdestructura_estructura().getLongitud() * e.getIdestructura_estructura().getNivel();
        if (codigoLength % 2 != 0) {
            response.put("status", "error");
            response.put("message", "Longitud del código ingresado incorrecto.");
            return response;
        }
        if (codigoLength>2){
            int d = 0;
            int h = 2;
            while (codigoLength > h){
                Proyectos existingEstrfunc = dao.findByCodigo(e.getCodigo().substring(d,h));
                if (existingEstrfunc == null) {
                    response.put("status", "error");
                    response.put("message", "Error: Código "+e.getCodigo().substring(d,h)+" no existe.");
                    return response;
                }
                h += 2;
            }
        }
        Proyectos existingEstrfunc = dao.findByCodigo(e.getCodigo());
        if (existingEstrfunc != null) {
            response.put("status", "error");
            response.put("message", "Error: Código ya existe.");
            return response;
        }
        if (codigoLength.equals(expectedLength)) {
            try{
                dao.save(e);
            } catch (Exception ex) {
                response.put("status","error");
                response.put("message",ex.getMessage());
                return response;
            }
            response.put("status", "success");
            response.put("message", "Datos guardados con éxito.");
        } else {
            response.put("status", "error");
            response.put("message", "Validación fallida: Longitud del código ingresado incorrecto.");
        }
        return response;
    }
    public Map<String, Object> update(Proyectos e) {
        Map<String, Object> response = new HashMap<>();
        if (e == null || e.getCodigo() == null || e.getIdestructura_estructura() == null) {
            response.put("status", "error");
            response.put("message", "Dato de ingreso invalido.");
            return response;
        }
        Long codigoLength = (long) e.getCodigo().length();
        Long expectedLength = e.getIdestructura_estructura().getLongitud() * e.getIdestructura_estructura().getNivel();
        if (codigoLength % 2 != 0) {
            response.put("status", "error");
            response.put("message", "Longitud del código ingresado incorrecto.");
            return response;
        }
        if (codigoLength>2){
            int d = 0;
            int h = 2;
            while (codigoLength > h){
                Proyectos existingEstrfunc = dao.findByCodigo(e.getCodigo().substring(d,h));
                if (existingEstrfunc == null) {
                    response.put("status", "error");
                    response.put("message", "Error: Código "+e.getCodigo().substring(d,h)+" no existe.");
                    return response;
                }
                h += 2;
            }
        }
        if (codigoLength.equals(expectedLength)) {
            try{
                dao.save(e);
            } catch (Exception ex) {
                response.put("status","error");
                response.put("message",ex.getMessage());
                return response;
            }
            response.put("status", "success");
            response.put("message", "Datos guardados con éxito.");
        } else {
            response.put("status", "error");
            response.put("message", "Validación fallida: Longitud del código ingresado incorrecto.");
        }
        return response;
    }
    public Map<String, Object> delete(Long idProyecto) {
        Map<String, Object> response = new HashMap<>();

        Optional<Proyectos> optionalProject = dao.findById(idProyecto);

        if (optionalProject.isPresent()) {
            Proyectos project = optionalProject.get();
            System.out.println("Project Code: " + project.getCodigo());

            // Fetch count directly instead of fetching the list
            List<Proyectos> relatedProjectCount = dao.findByCodigoMayor(project.getCodigo());

            if (relatedProjectCount.size() == 1) {
                dao.deleteById(project.getIdproyecto());
                response.put("status","success");
                response.put("message", "Eliminado");
            } else {
                response.put("status","denied");
                response.put("message", "No se puede eliminar registro");
            }
        } else {
            response.put("status","denied");
            response.put("message", "Proyecto no encontrado");
        }

        return response;
    }

    public List<Proyectos> findByCodigoMayor(String codigo){
        return dao.findByCodigoMayor(codigo);
    }

}

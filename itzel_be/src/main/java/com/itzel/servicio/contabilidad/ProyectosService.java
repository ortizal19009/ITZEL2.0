package com.itzel.servicio.contabilidad;

import com.itzel.interfaces.contabilidad.Proyectos_rep_int;
import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.modelo.contabilidad.Proyectos;
import com.itzel.repositorio.contabilidad.PresupuestoR;
import com.itzel.repositorio.contabilidad.ProyectosR;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ProyectosService {
    @Autowired
    private ProyectosR dao;
    @Autowired
    private PresupuestoR daoP;

    public List<Proyectos> findAll(Sort sort){
        return dao.findAll(sort);
    }
    //Encontrar todos los proyectos menos el de codigo 00
    public List<Proyectos> findByCodigoNotOrderByCodigoAsc(String code){
     return dao.findByCodigoNotOrderByCodigoAsc(code);
    }

    public Optional<Proyectos> findById(short idestrfunc){
        return dao.findById(idestrfunc);
    }
    public Proyectos findByCodigo(String codigo){
        return dao.findByCodigo(codigo);
    }
    public Proyectos findByNombre(String nombre){
        return dao.findByNombre(nombre);
    }
    public Proyectos saveOne(Proyectos p){
        return dao.save(p);
    }
    public Map<String, Object> save(Proyectos e) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (e == null || e.getCodigo() == null || e.getEstructura() == null) {
                response.put("status", "error");
                response.put("message", "Dato de ingreso inválido.");
                return response;
            }

            Long codigoLength = (long) e.getCodigo().length();
            Long expectedLength = e.getEstructura().getLongitud() * e.getEstructura().getNivel();

            if (codigoLength % 2 != 0) {
                response.put("status", "error");
                response.put("message", "Longitud del código ingresado incorrecta.");
                return response;
            }

            if (codigoLength > 2) {
                int d = 0;
                int h = 2;
                while (codigoLength > h) {
                    Proyectos existingEstrfunc = dao.findByCodigo(e.getCodigo().substring(d, h));
                    if (existingEstrfunc == null) {
                        response.put("status", "error");
                        response.put("message", "Error: Código " + e.getCodigo().substring(d, h) + " no existe.");
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
                dao.save(e);
                response.put("status", "success");
                response.put("message", "Datos guardados con éxito.");
            } else {
                response.put("status", "error");
                response.put("message", "Validación fallida: Longitud del código ingresado incorrecta.");
            }

        } catch (Exception ex) {
            response.put("status", "error");
            response.put("message", ex.getMessage());
            response.put("errorType", ex.getClass().getName()); // Tipo de excepción
            response.put("cause", ex.getCause() != null ? ex.getCause().toString() : "N/A");

            // Opcional: stacktrace como string
            StringWriter sw = new StringWriter();
            ex.printStackTrace(new PrintWriter(sw));
            response.put("stacktrace", sw.toString());
        }

        return response;
    }
    public Map<String, Object> update(Proyectos e) {
        Map<String, Object> response = new HashMap<>();
        if (e == null || e.getCodigo() == null || e.getEstructura() == null) {
            response.put("status", "error");
            response.put("message", "Dato de ingreso invalido.");
            return response;
        }
        Long codigoLength = (long) e.getCodigo().length();
        Long expectedLength = e.getEstructura().getLongitud() * e.getEstructura().getNivel();
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
    public Map<String, Object> delete(short idProyecto) {
        Map<String, Object> response = new HashMap<>();
    List<Presupuesto> presupuestos = daoP.findByIdPresupuesto(idProyecto);
    System.out.println("Número de presupuestos " + presupuestos.size());
    if(presupuestos.isEmpty()) {
        Optional<Proyectos> optionalProject = dao.findById(idProyecto);

        if (optionalProject.isPresent()) {
            Proyectos project = optionalProject.get();
            System.out.println("Project Code: " + project.getCodigo());

            // Fetch count directly instead of fetching the list
            List<Proyectos> relatedProjectCount = dao.findByCodigoMayor(project.getCodigo());

            if (relatedProjectCount.size() == 1) {
                dao.deleteById(project.getIdproyecto());
                response.put("status", "success");
                response.put("message", "Eliminado");
            } else {
                response.put("status", "error");
                response.put("message", "No se puede eliminar registro");
            }
        } else {
            response.put("status", "error");
            response.put("message", "Proyecto no encontrado");
        }
    }else{
        response.put("status", "error");
        response.put("message", "No se puede eliminar porque se esta usanddo en "+presupuestos.size()+" partidas de gastos");
    }
        return response;
    }

    public List<Proyectos> findByCodigoMayor(String codigo){
        return dao.findByCodigoMayor(codigo);
    }
    public  List<Proyectos_rep_int> findByNivel(Long nivel){
        return dao.findByNivel(nivel);
    }
    public  List<Proyectos_rep_int> findByGrupo(String codigo){
        return dao.findByGrupo(codigo);
    }
    public  List<Proyectos> findByCodNom(String dato){
        return dao.findByCodNom(dato);
    }
    public List<Proyectos> findByCodigoLike(String codigo){
        return dao.findByCodigoStartingWith(codigo);
    }
    public List<Proyectos> findByNameLike(String nombre){
        return dao.buscarPorNombre(nombre);
    }
}

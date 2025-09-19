package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import com.itzel.servicio.contabilidad.CertificacionService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/certificaciones")
@CrossOrigin("*")
public class CertificacionesApi {
    @Autowired
    private CertificacionService certificacionService;
    //Consultar todas las certificaciones por tipo, para consultar las certificaciones o los reintegros
    @GetMapping("/tipo")
    public ResponseEntity<List<Certificaciones>> findFirstByTipoOrderByNumeroAsc(@RequestParam short tipo){
        List<Certificaciones> certificacion = certificacionService.findFirstByTipoOrderByNumeroAsc(tipo);
        if(certificacion.isEmpty()){
            return ResponseEntity.noContent().build();
        }else{
            return ResponseEntity.ok(certificacion);
        }
    }
    @PostMapping
    ResponseEntity<Certificaciones> saveCertificacion(@RequestBody Certificaciones c){
        return ResponseEntity.ok(certificacionService.save(c));
    }
    @DeleteMapping("/{idcertificacion}")
    public ResponseEntity<Void> deleteCertificacionById(@PathVariable Long idcertificacion) {
        try {
            certificacionService.deleteByIdCertificacion(idcertificacion);
            return ResponseEntity.noContent().build(); // 204 si se eliminó
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build(); // 404 si no existe
        }
    }

    @GetMapping("/lastbytipo")
    public ResponseEntity<Certificaciones> findLastByTipo(@RequestParam short tipo){
        try {
            certificacionService.findLastByTipo(tipo);
            return ResponseEntity.noContent().build(); // 204 si se eliminó
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build(); // 404 si no existe
        }
    }

}

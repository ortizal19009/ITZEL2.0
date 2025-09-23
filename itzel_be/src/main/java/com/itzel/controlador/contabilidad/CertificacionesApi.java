package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Certificaciones;
import com.itzel.servicio.contabilidad.CertificacionService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
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
        System.out.println("Numero "+c.getNumero());
        System.out.println("Descripcion "+ c.getDescripcion());
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
            Certificaciones c = certificacionService.findLastByTipo(tipo);
            return ResponseEntity.ok(c); // 204 si se eliminó
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build(); // 404 si no existe
        }
    }
    @GetMapping("/findall")
    public ResponseEntity<List<Certificaciones>> getByNumDate(@RequestParam short tipo, @RequestParam LocalDate fechaInicio, @RequestParam LocalDate fechaFin, @RequestParam short min, @RequestParam short max){
        return ResponseEntity.ok(certificacionService.getByNumDate(tipo, fechaInicio, fechaFin, min, max));
    }

    @GetMapping
    public ResponseEntity<Certificaciones> findById(@RequestParam Long idcertificacion) {
        return certificacionService.findById(idcertificacion)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }


}

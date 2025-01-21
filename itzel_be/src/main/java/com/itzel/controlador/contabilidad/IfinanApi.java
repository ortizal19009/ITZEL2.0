package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Ifinan;
import com.itzel.servicio.contabilidad.IfinanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ifinan")
@CrossOrigin("*")
public class IfinanApi {
    @Autowired
    IfinanService ifinanServicio;
    @GetMapping("/getall")
    public ResponseEntity<List<Ifinan>> getAllIfinan(){
        return ResponseEntity.ok(ifinanServicio.findAll(Sort.by(Sort.Order.asc("codifinan"))));
    }

    @GetMapping
    public List<Ifinan> getIfinan(@Param(value = "codifinan") String codifinan,
                                  @Param(value = "nomifinan") String nomifinan) {
        if (codifinan != null) {
            return ifinanServicio.findByCodifinan(codifinan);
        }
        if (nomifinan != null) {
            return ifinanServicio.findByNomifinan(nomifinan.toLowerCase());
        } else return null;
    }

    @PostMapping
    public Ifinan updateOrSave(@RequestBody Ifinan x) {
        return ifinanServicio.save(x);
    }

    @GetMapping("/{idifinan}")
    public ResponseEntity<Ifinan> getByIdNovedad(@PathVariable Long idifinan) {
        Ifinan x = ifinanServicio.findById(idifinan)
                .orElse(null);
        return ResponseEntity.ok(x);
    }

    @PutMapping("/{idifinan}")
    public ResponseEntity<Ifinan> update(@PathVariable Long idifinan, @RequestBody Ifinan x) {
        Ifinan y = ifinanServicio.findById(idifinan)
                .orElse(null);
        // y.setCodifinan(x.getCodifinan());
        // y.setNomifinan(x.getNomifinan());
        // y.setFoto(x.getFoto());

        Ifinan actualizar = ifinanServicio.save(y);
        return ResponseEntity.ok(actualizar);
    }

    // @DeleteMapping("/{idifinan}")
    // private ResponseEntity<Boolean> deleteIfinan(@PathVariable("idifinan") Long
    // idifinan) {
    // ifinanServicio.deleteById(idifinan);
    // return ResponseEntity.ok(!(ifinanServicio.findById(idifinan) != null));
    // }
}

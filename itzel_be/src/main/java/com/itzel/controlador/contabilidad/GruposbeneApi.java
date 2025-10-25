package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Gruposbene;
import com.itzel.servicio.contabilidad.GrupobeneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/gruposbene")
public class GruposbeneApi {
    @Autowired
    GrupobeneService grubenServicio;

    @GetMapping
    public List<Gruposbene> getAllLista(@Param(value = "nomgru") String nomgru) {
        if (nomgru != null) {
            return grubenServicio.findByNomgru(nomgru.toLowerCase());
        } else {
            return grubenServicio.findAll();
        }
    }

    @GetMapping("/{idgrupo}")
    public ResponseEntity<Gruposbene> getByIdgrupobene(@PathVariable Long idgrupo) {
        Gruposbene grupobene = grubenServicio.findById(idgrupo)
                .orElse(null);
        return ResponseEntity.ok(grupobene);
    }


    @PostMapping
    public Gruposbene updateOrSave(@RequestBody Gruposbene x) {
        return grubenServicio.save(x);
    }


    @PutMapping("/{idgrupo}")
    public ResponseEntity<Gruposbene> update(@PathVariable Long idgrupo, @RequestBody Gruposbene x) {
        Gruposbene y = grubenServicio.findById(idgrupo)
                .orElse(null);
        y.setCodgru(x.getCodgru());
        y.setNomgru(x.getNomgru());
        y.setModulo1(x.getModulo1());
        y.setModulo2(x.getModulo2());
        y.setModulo3(x.getModulo3());
        y.setModulo4(x.getModulo4());
        y.setModulo5(x.getModulo5());
        y.setModulo6(x.getModulo6());

        Gruposbene actualizar = grubenServicio.save(y);
        return ResponseEntity.ok(actualizar);
    }

    @DeleteMapping("/{idgrupo}")
    private ResponseEntity<Boolean> deleteGrupobene(@PathVariable("idgrupo") Long idgrupo) {
        grubenServicio.deleteById(idgrupo);
        return ResponseEntity.ok(!(grubenServicio.findById(idgrupo) != null));
    }

}

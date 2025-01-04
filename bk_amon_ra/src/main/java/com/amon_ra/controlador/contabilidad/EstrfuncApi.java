package com.amon_ra.controlador.contabilidad;

import com.amon_ra.modelo.contabilidad.Estrfunc;
import com.amon_ra.servicio.contabilidad.EstrfuncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/estrfunc")
@CrossOrigin("*")
public class EstrfuncApi {
    @Autowired
    private EstrfuncService estrfuncService;

    @GetMapping
    public ResponseEntity<List<Estrfunc>> getAll(){
        List<Estrfunc> estrfuncs  = estrfuncService.findAll();
        if (estrfuncs != null){
            return ResponseEntity.ok(estrfuncs);
        }
        return  ResponseEntity.noContent().build();
    }
}

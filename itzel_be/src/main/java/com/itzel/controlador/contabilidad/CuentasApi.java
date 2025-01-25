package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import com.itzel.servicio.contabilidad.CuentasService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@RestController
@RequestMapping("/cuentas")
@CrossOrigin("*")
public class CuentasApi {
    @Autowired
    private CuentasService cuentasService;

    @GetMapping
    public ResponseEntity<List<Cuentas>> getAll(){
        return ResponseEntity.ok(cuentasService.findAll());
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Cuentas c){
        return ResponseEntity.ok(cuentasService.save(c));
    }
    @GetMapping("/byPages")
    public ResponseEntity<Page<Cuentas>> getCuentasPages( @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size){
        return ResponseEntity.ok(cuentasService.getCuentasByPage(page, size));
    }
    @GetMapping("/bycodOrnom")
    public ResponseEntity<Page<Cuentas>> getByCodOrDenom(@RequestParam String codcue, @RequestParam String nomcue, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size){
        Page<Cuentas> cuentas = null;
        if(codcue != null){
            System.out.println("codcue: "+codcue);
            cuentas =cuentasService.findByCod(codcue,page, size);
        }else if (nomcue != null) {
            System.out.println("nomcue: "+nomcue);
            cuentas = cuentasService.findByDenom(nomcue.toLowerCase(),page, size);
        }
        return ResponseEntity.ok(cuentas);

    }
    @GetMapping("/byId")
    public ResponseEntity<Optional<Cuentas>> getById(@RequestParam Long idcuenta){
        return ResponseEntity.ok(cuentasService.findById(idcuenta));
    }
}

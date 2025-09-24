package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import com.itzel.servicio.contabilidad.CuentasService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
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
            cuentas =cuentasService.findByCod(codcue,page, size);
        }else if (nomcue != null) {
            cuentas = cuentasService.findByDenom(nomcue.toLowerCase(),page, size);
        }
        return ResponseEntity.ok(cuentas);

    }
    @GetMapping("/byId")
    public ResponseEntity<Optional<Cuentas>> getById(@RequestParam Long idcuenta){
        return ResponseEntity.ok(cuentasService.findById(idcuenta));
    }
    //buscar una sola cuenta por el codigo cuenta (codcue)
    @GetMapping("/byCodcue")
    public ResponseEntity<Cuentas> getByCodcue(@RequestParam String codcue) {
        return cuentasService.findByCodcue(codcue)
                .map(ResponseEntity::ok)        // Si existe → 200 con la cuenta
                .orElse(ResponseEntity.noContent().build()); // Si no existe → 404
    }
    @PutMapping
    public ResponseEntity<Cuentas> updateCuentas(@RequestBody Cuentas c) {
        Cuentas cuenta = cuentasService.findById(c.getIdcuenta())
                .orElseThrow(() -> new RuntimeException("Cuenta no encontrada"));
        // Copia todos los atributos excepto "idcuenta"
        BeanUtils.copyProperties(c, cuenta, "idcuenta");

        return ResponseEntity.ok(cuentasService.saveOne(cuenta));
    }

}

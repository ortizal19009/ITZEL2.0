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
    private CuentasService cueService;

    @GetMapping
    public ResponseEntity<List<Cuentas>> getAll(){
        return ResponseEntity.ok(cueService.findAll());
    }
    @PostMapping
    public ResponseEntity<Object> save(@RequestBody Cuentas c){
        return ResponseEntity.ok(cueService.save(c));
    }
    @GetMapping("/byPages")
    public ResponseEntity<Page<Cuentas>> getCuentasPages( @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size){
        return ResponseEntity.ok(cueService.getCuentasByPage(page, size));
    }
    @GetMapping("/bycodOrnom")
    public ResponseEntity<Page<Cuentas>> getByCodOrDenom(@RequestParam String codcue, @RequestParam String nomcue, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size){
        Page<Cuentas> cuentas = null;
        if(codcue != null){
            cuentas =cueService.findByCod(codcue,page, size);
        }else if (nomcue != null) {
            cuentas = cueService.findByDenom(nomcue.toLowerCase(),page, size);
        }
        return ResponseEntity.ok(cuentas);

    }
    @GetMapping("/byId")
    public ResponseEntity<Optional<Cuentas>> getById(@RequestParam Long idcuenta){
        return ResponseEntity.ok(cueService.findById(idcuenta));
    }
    //buscar una sola cuenta por el codigo cuenta (codcue)
    @GetMapping("/byCodcue")
    public ResponseEntity<Cuentas> getByCodcue(@RequestParam String codcue) {
        return cueService.findByCodcue(codcue)
                .map(ResponseEntity::ok)        // Si existe → 200 con la cuenta
                .orElse(ResponseEntity.noContent().build()); // Si no existe → 404
    }
    @PutMapping
    public ResponseEntity<Cuentas> updateCuentas(@RequestBody Cuentas c) {
        Cuentas cuenta = cueService.findById(c.getIdcuenta())
                .orElseThrow(() -> new RuntimeException("Cuenta no encontrada"));
        // Copia todos los atributos excepto "idcuenta"
        BeanUtils.copyProperties(c, cuenta, "idcuenta");

        return ResponseEntity.ok(cueService.saveOne(cuenta));
    }

    // Cuentas por Tiptran para los DataList de Cuentas
    @GetMapping("/datalist")
    public List<Cuentas> getByTiptranYCodcue(@RequestParam("tiptran") Short tiptran, @RequestParam("codcue") String codcue) {
        return cueService.recuperaPorTiptranYCodcue(tiptran, codcue);
    }


}

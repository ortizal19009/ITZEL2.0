package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.servicio.contabilidad.PresupuestoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/presupuesto")
@CrossOrigin("*")
public class PresupuestoApi {
    @Autowired
    private PresupuestoService presuService;
    @GetMapping
    public ResponseEntity<Page<Presupuesto>> getdAllByPage(@RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presuService.findAllByPage(page, size));
    }
    @GetMapping("/tippar")
    public ResponseEntity<Page<Presupuesto>> getByTipparPageable(@RequestParam int tippar, @RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presuService.findByTipparPageable(tippar, page, size));
    }
    @GetMapping("/codnom")
    public ResponseEntity<Page<Presupuesto>> getByParDenom(@RequestParam String dato, @RequestParam int tippar, @RequestParam int page, @RequestParam int size){
        return ResponseEntity.ok(presuService.findByParDenom( dato.toLowerCase(), tippar, page, size));
    }
    @GetMapping("/codpar")
    public ResponseEntity<Presupuesto> getByCodPar(@RequestParam String codpar){
        return ResponseEntity.ok(presuService.findByCodPar(codpar));

    }
    @GetMapping("/byId")
    public ResponseEntity<Optional<Presupuesto>> findById(@RequestParam Short idpresupuesto){
        return ResponseEntity.ok(presuService.findById(idpresupuesto));
    }
    @GetMapping("/presupuestosLike")
    public ResponseEntity<Map<String, Object>> findByCodigoProyectoLike(@RequestParam String codigo){
        List<Presupuesto> presupuestos = presuService.findByCodigoProyectoLike(codigo);
        Map<String, Object> response = new HashMap<>();
        if(presupuestos.isEmpty()){
            response.put("message", "Datos no encontrados");
            response.put("status", "error");
        }
        else{
            response.put("message", "Datos encontrados");
            response.put("status", "success");
            response.put("body", presupuestos);
        }
        return ResponseEntity.ok(response);
    }
    @GetMapping("/debhab")
    public ResponseEntity<Map<String, Object>> findTipparAndCodpar(@RequestParam int tippar, @RequestParam String codpar){
        List<Presupuesto> presupuestos = presuService.findTipparAndCodpar(tippar, codpar);
        Map<String, Object> response = new HashMap<>();
        if(presupuestos.isEmpty()){
            response.put("message", "Datos no encontrados");
            response.put("status", "warning");
        }
        else{
            response.put("message", "Datos encontrados");
            response.put("status", "success");
            response.put("body", presupuestos);
        }
        return ResponseEntity.ok(response);
    }
    // Busca por tippar, codpar Y nompar
    @GetMapping("/busca")
    public ResponseEntity<List<Presupuesto>> buscarPartidas(@RequestParam short tippar, @RequestParam String codpar,
                                                            @RequestParam String nompar) {
        List<Presupuesto> resultados = presuService.buscarPartidasPorCampos(tippar, codpar, nompar);
        return ResponseEntity.ok(resultados);
    }

    // Valida códpar
    @GetMapping("/valcodpar/{codpar}")
    public ResponseEntity<Boolean> validarCodpar(@PathVariable String codpar) {
        boolean existe = presuService.valCodpar(codpar);
        return ResponseEntity.ok(existe);
    }

    // Valida nompar
    @GetMapping("/valnompar/{nompar}")
    public ResponseEntity<Boolean> valNompar(@PathVariable String nompar) {
        boolean existe = presuService.valNompar(nompar);
        return ResponseEntity.ok(existe);
    }

    // Cuenta las partidas del Presupuesto por idclasificador
    @GetMapping("/countidclasificador/{idclasificador}")
    public ResponseEntity<Short> cuentaPartidasPorClasificador(@PathVariable short idclasificador) {
        short cantidad = presuService.cuentaPartidasPorClasificador(idclasificador);
        return ResponseEntity.ok(cantidad);
    }

    // Guarda nuevo
    @PostMapping
    public Presupuesto save(@RequestBody Presupuesto partida) {
        return presuService.save(partida);
    }

    // Busca por idpresupuesto
    @GetMapping("/{idpresupuesto}")
    public ResponseEntity<Presupuesto> getByIdPresupuesto(@PathVariable Short idpresupuesto) {
        Presupuesto partida = presuService.findById(idpresupuesto)
                .orElseThrow();
        return ResponseEntity.ok(partida);
    }

    // Actualiza
    @PutMapping("/{idpresupuesto}")
    public Presupuesto actualiza(@PathVariable Short idpresupuesto, @RequestBody Presupuesto x) {
        return presuService.actualiza(idpresupuesto, x);
    }

    // Elimina
    @DeleteMapping("/{idpresupuesto}")
    public ResponseEntity<Void> delete(@PathVariable("idpresupuesto") Short idpresupuesto) {
        presuService.deleteById(idpresupuesto);
        return ResponseEntity.noContent().build();
    }

}

package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Beneficiarios;
import com.itzel.servicio.contabilidad.BeneficiariosService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/beneficiarios")
public class BeneficiariosApi {
    @Autowired
    private BeneficiariosService beneServicio;

    // Lista de beneficiarios por nombre, codigo o ruc
    @GetMapping
    public List<Beneficiarios> findBeneficiarios(@Param(value = "nomben") String nomben,
                                                 @Param(value = "codben") String codben, @Param(value = "rucben") String rucben,
                                                 @Param(value = "ciben") String ciben) {
        return beneServicio.findBeneficiarios(nomben.toLowerCase(), codben, rucben, ciben);
    }

    // Busca por Nombre para los datalist
    @GetMapping("/nomben")
    public ResponseEntity<?> findByNomben(@RequestParam("nomben") String nomben) {
        List<Beneficiarios> beneficiarios = beneServicio.findByNomben(nomben.toLowerCase());
        if (beneficiarios == null || beneficiarios.isEmpty()) {
            return ResponseEntity.noContent().build(); // ✅ 204 No Content
        }
        return ResponseEntity.ok(beneficiarios); // ✅ 200 OK con la lista
    }
    // Busca por Nombre y grupo para los datalist
    @GetMapping("/nombengru")
    public List<Beneficiarios> findByGrupoBene(@Param(value = "nomben") String nomben,
                                               @Param(value = "idgrupo") Long idgrupo) {
        return beneServicio.findByNombenGru(nomben.toLowerCase(), idgrupo);
    }

    // Valida el nombre del Beneficiario
    @GetMapping("/valnomben")
    public ResponseEntity<Boolean> valNomben(@Param(value = "nomben") String nomben) {
        boolean rtn = beneServicio.valNomben(nomben.toLowerCase());
        return ResponseEntity.ok(rtn);
    }

    // Ultimo código de beneficiario (por grupo)
    @GetMapping("/ultcodigo")
    public Beneficiarios findUltCodigo(@Param(value = "idgrupo") Long idgrupo) {
        return beneServicio.findUltCodigo(idgrupo);
    }

    @GetMapping("/siguicodigo")
    public String getSiguienteAsiento(@Param(value = "idgrupo") Long idgrupo) {
        return beneServicio.siguienteCodigo(idgrupo);
    }

    // Valida el codben del Beneficiario
    @GetMapping("/valcodben")
    public ResponseEntity<Boolean> valCodben(@Param(value = "codben") String codben) {
        boolean f = beneServicio.valCodben(codben);
        return ResponseEntity.ok(f);
    }

    // Valida rucben del Beneficiario
    @GetMapping("/valrucben")
    public ResponseEntity<Boolean> valRucben(@Param(value = "rucben") String rucben) {
        boolean f = beneServicio.valRucben(rucben);
        return ResponseEntity.ok(f);
    }

    // Valida ciben del Beneficiario
    @GetMapping("/valciben")
    public ResponseEntity<Boolean> valCiben(@Param(value = "ciben") String ciben) {
        boolean f = beneServicio.valCiben(ciben);
        return ResponseEntity.ok(f);
    }

    @GetMapping("/{idbene}")
    public Optional<Beneficiarios> findByIdBene(@PathVariable Long idbene) {
        return beneServicio.findById(idbene);
    }

    // Cuenta por Idifinan
    @GetMapping("/countByIdifinan")
    public Long countByIdifinan(@Param(value = "idifinan") Long idifinan) {
        return beneServicio.countByIdifinan(idifinan);
    }

    @PostMapping
    public ResponseEntity<Beneficiarios> save(@RequestBody Beneficiarios x) {
        return ResponseEntity.ok(beneServicio.save(x));
    }

    @PutMapping("/{idbene}")
    public ResponseEntity<Beneficiarios> updateBeneficiario(@PathVariable Long idbene, @RequestBody Beneficiarios x) {
        Beneficiarios y = beneServicio.findById(idbene)
                .orElseThrow(() -> new RuntimeException("Beneficiario no encontrado"));

        // Copiar propiedades excepto campos que NO quieres sobreescribir
        BeanUtils.copyProperties(x, y, "idbene", "usucrea", "feccrea");
        Beneficiarios z = beneServicio.save(y);
        return ResponseEntity.ok(z);
    }

    @DeleteMapping(value = "/{idbene}")
    public ResponseEntity<Boolean> deleteById(@PathVariable("idbene") Long idbene) {
        beneServicio.deleteById(idbene);
        return ResponseEntity.ok(!(beneServicio.findById(idbene) != null));
    }
    //Obtener proveedor o e
    @GetMapping("/by-prefix")
    public ResponseEntity<List<Beneficiarios>> findByCodbenStartingWith(@RequestParam String prefix) {
        List<Beneficiarios> beneficiarios = beneServicio.findByCodbenStartingWith(prefix);

        if (beneficiarios == null || beneficiarios.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(beneficiarios);
    }
    @GetMapping("/by-prefix-nombre")
    public ResponseEntity<List<Beneficiarios>> findByCodbenStartingWithIgnoreCaseAndSwmodulo2AndNombenContainingIgnoreCase(@RequestParam String prefix, @RequestParam @DefaultValue(value = "true") boolean swmodulo2, @RequestParam String nomben){
        return ResponseEntity.ok(beneServicio.findByCodbenStartingWithIgnoreCaseAndSwmodulo2AndNombenContainingIgnoreCase(prefix, swmodulo2, nomben));
    }

}

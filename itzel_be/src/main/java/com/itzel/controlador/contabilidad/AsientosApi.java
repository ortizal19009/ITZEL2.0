package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Asientos;
import com.itzel.servicio.contabilidad.AsientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/asientos")
public class AsientosApi {

    private final AsientoService asieService;

    // Busca asientos desde/hasta por números y fecha
    @GetMapping("/busca")
    public ResponseEntity<List<Asientos>> buscaAsientos(
            @RequestParam Long desdeNum,
            @RequestParam Long hastaNum,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desdeFecha,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hastaFecha) {
        List<Asientos> resultados = asieService.buscaByNumeroYFecha(desdeNum, hastaNum, desdeFecha, hastaFecha);
        return ResponseEntity.ok(resultados);
    }

    // Número del último asiento
    @GetMapping("/ultimo")
    public ResponseEntity<Long> getUltimoNumeroAsiento() {
        Long ultimoNumero = asieService.obtenerUltimoNumero();
        return ResponseEntity.ok(ultimoNumero);
    }

    // Siguiente Número de asiento
    @GetMapping("/siguiente")
    public ResponseEntity<Long> siguienteNumero() {
        Long ultimoNumero = asieService.siguienteNumero();
        return ResponseEntity.ok(ultimoNumero);
    }

    // Última fecha de asiento
    @GetMapping("/ultimafecha")
    public LocalDate obtenerUltimaFecha() {
        return asieService.obtenerUltimaFecha();
    }

    // Ultimo comprobante
    @GetMapping("/ultimocompro")
    public Long ultimocompro(@RequestParam("tipcom") Byte tipcom) {
        return asieService.findLastComproByTipcom(tipcom);
    }

    // Valida número de comprobante
    @GetMapping("/valcompro")
    public ResponseEntity<Boolean> validarComprobante(
            @RequestParam("tipcom") Byte tipcom,
            @RequestParam("compro") Long compro) {
        boolean existe = asieService.validarComprobante(tipcom, compro);
        return ResponseEntity.ok(existe);
    }

    // Guarda nuevo
    @PostMapping
    public Asientos save(@RequestBody Asientos asiento) {
        return asieService.save(asiento);
    }

    // Buscar por idasiento, cuando no existe retorna 404 (Not found)
    @GetMapping("/{idasiento}")
    public ResponseEntity<Asientos> getByIdasiento(@PathVariable Short idasiento) {
        return asieService.findById(idasiento)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Actualiza totdeb y totcre
    // @PutMapping("/totales")
    // public ResponseEntity<String> actualizarTotalesAsiento(
    // @RequestParam short idasiento,
    // @RequestParam BigDecimal totdeb,
    // @RequestParam BigDecimal totcre) {
    // int rows = asieService.actualizarTotales(idasiento, totdeb, totcre);
    // if (rows > 0) {
    // return ResponseEntity.ok("Totales del asiento " + idasiento + " actualizados
    // con éxito.");
    // } else {
    // return ResponseEntity.notFound().build();
    // }
    // }

    @PatchMapping("/totales")
    public void updateTotdebAndTotcre(
            @RequestParam Short idasiento,
            @RequestParam BigDecimal totdeb,
            @RequestParam BigDecimal totcre) {
        asieService.updateTotdebAndTotcre(idasiento, totdeb, totcre);
    }

}

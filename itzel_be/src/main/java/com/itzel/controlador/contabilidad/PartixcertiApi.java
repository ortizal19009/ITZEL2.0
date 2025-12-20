package com.itzel.controlador.contabilidad;

import com.itzel.modelo.contabilidad.Partixcerti;
import com.itzel.servicio.contabilidad.PartixcertiService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/partixcerti")
@CrossOrigin("*")

public class PartixcertiApi {

    private final PartixcertiService parxcerService;

    // Partidas por Certificacion
    @GetMapping("/busca/{idcertificacion}")
    public List<Partixcerti> obtenerPorIdAsiento(@PathVariable Short idcertificacion) {
        return parxcerService.obtenerPorIdcertificacion(idcertificacion);
    }

    // Partixcerti con saldo a una fecha y desde/hasta
    @GetMapping("/consaldo")
    public ResponseEntity<List<Partixcerti>> consultarPartidasConSaldo(
            @RequestParam("fechaHasta") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaHasta,
            @RequestParam("numDesde") int numDesde,
            @RequestParam("numHasta") int numHasta) {
        List<Partixcerti> resultados = parxcerService.obtenerPartidasConSaldo(fechaHasta, numDesde, numHasta);
        return ResponseEntity.ok(resultados);
    }

    // Cuenta las partixcerti de un Partida
    @GetMapping("/contarporpartida/{idpresupuesto}")
    public ResponseEntity<Short> contarPorIdpresupuesto(@PathVariable Short idpresupuesto) {
        Short total = parxcerService.contarPorIdpresupuesto(idpresupuesto);
        return ResponseEntity.ok(total);
    }

    // Cuenta las partixcerti de una Certificación
    @GetMapping("/contarporcertificacion/{idcertificacion}")
    public ResponseEntity<Short> contarPorIdcertificacion(@PathVariable Short idcertificacion) {
        Short total = parxcerService.contarPorIdcertificacion(idcertificacion);
        return ResponseEntity.ok(total);
    }

    // Guarda nuevo. Actualiza: certificaciones.total y presupuesto.totcerti
    @PostMapping
    public ResponseEntity<Partixcerti> creaPartixcerti(@RequestBody Partixcerti parxcer) {
        Partixcerti nueva = parxcerService.creaPartixceriYActualizaTotal(parxcer);
        return ResponseEntity.status(HttpStatus.CREATED).body(nueva);
    }

    // Actualiza partixcerti Actualiza: certificaciones.total y presupuesto.totcerti
    @PutMapping("/{idparxcer}")
    public ResponseEntity<Partixcerti> actualizaPartida(
            @PathVariable Long idparxcer,
            @RequestBody Partixcerti parxcer) {
        Partixcerti y = parxcerService.actualizarPartidaYRecalcularTotal(idparxcer, parxcer);
        return ResponseEntity.ok(y);
    }

    // Elimina y actualiza certificaciones.total y presupuesto.totcerti
    @DeleteMapping("/{idparxcer}")
    public ResponseEntity<Void> eliminaPartixcerti(@PathVariable Long idparxcer) {
        parxcerService.eliminaPartixcertiYActualizaTotal(idparxcer);
        return ResponseEntity.noContent().build();
    }

    // Certificaciones de una Partida en un rango de fechas
    @GetMapping("/partida/{idpresupuesto}")
    public ResponseEntity<List<Partixcerti>> getPartidasPorPresupuestoYFechas(
            @PathVariable Short idpresupuesto,
            @RequestParam("fechaDesde") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaDesde,
            @RequestParam("fechaHasta") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaHasta) {
        List<Partixcerti> partidas = parxcerService.obtenerPartidasPorPresupuestoYFechas(idpresupuesto, fechaDesde,
                fechaHasta);
        if (partidas.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(partidas);
    }

}

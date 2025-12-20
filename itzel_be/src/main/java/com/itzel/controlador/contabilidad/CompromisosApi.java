package com.itzel.controlador.contabilidad;


import com.itzel.modelo.contabilidad.Compromisos;
import com.itzel.servicio.contabilidad.CompromisoService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/compromisos")
@CrossOrigin("*")

public class CompromisosApi {

    private final CompromisoService comproService;

    // Busca compromisos desde/hasta por números y fecha
    @GetMapping("/busca")
    public ResponseEntity<List<Compromisos>> buscaCompromiso(
            @RequestParam long desdeNum,
            @RequestParam long hastaNum,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desdeFecha,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hastaFecha,
            @RequestParam short tipo) {
        List<Compromisos> resultados = comproService.buscaByNumeroYFechaYTipo(desdeNum, hastaNum, desdeFecha,
                hastaFecha, tipo);
        return ResponseEntity.ok(resultados);
    }

    // Ultimo compromiso por número
    // @GetMapping("/ultimo")
    // public ResponseEntity<Long> obtenerUltimoNumero(@RequestParam short tipo) {
    //    Long numero = comproService.obtenerUltimoNumero(tipo);
    //    return ResponseEntity.ok(numero);
    // }
    // Busca el ultimo Compromiso por número
    @GetMapping("/lastbytipo")
    public ResponseEntity<Compromisos> findLastByTipo(@RequestParam short tipo) {
        try {
            Compromisos c = comproService.findLastByTipo(tipo);
            return ResponseEntity.ok(c);
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Siguiente número de compromiso
    // @GetMapping("/siguiente")
    // public ResponseEntity<Long> obtenerSiguienteNumero(@RequestParam short tipo) {
    //    Long numero = comproService.obtenerSiguienteNumero(tipo);
    //    return ResponseEntity.ok(numero);
    // }

    @GetMapping("/{idcompromiso}")
    public ResponseEntity<Compromisos> getByIdcompromiso(@PathVariable Short idcompromiso) {
        Compromisos compromiso = comproService.findById(idcompromiso)
                .orElseThrow();
        return ResponseEntity.ok(compromiso);
    }

    // Valida numero
    @GetMapping("/valnumero/{tipo}/{numero}")
    public boolean valNumero(@PathVariable Short tipo, @PathVariable long numero) {
        return comproService.valNumero(tipo, numero);
    }

    // Conteo por idcontratacion
    @GetMapping("/contarporcontratacion/{idcontratacion}")
    public ResponseEntity<Short> contarPorIdcontratacion(@PathVariable Short idcontratacion) {
        Short total = comproService.contarPorIdcontratacion(idcontratacion);
        return ResponseEntity.ok(total);
    }

    // Cuenta cuantos Compromisos tiene un iddocumento
    @GetMapping("/contarpordocumento/{iddocumento}")
    public ResponseEntity<Short> contarPorIddocumento(@PathVariable Short iddocumento) {
        Short total = comproService.contarPorIddocumento(iddocumento);
        return ResponseEntity.ok(total);
    }

    // Busca pot tipo y número
    @GetMapping("/buscanumero")
    public ResponseEntity<Compromisos> buscarPorTipoYNumero(
            @RequestParam short tipo,
            @RequestParam long numero) {
        Compromisos compromiso = comproService.buscarPorTipoYNumero(tipo, numero);
        if (compromiso == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404
        }
        return ResponseEntity.ok(compromiso);
    }

    // Guardar nuevo
    @PostMapping
    public ResponseEntity<Compromisos> save(@RequestBody Compromisos x) {
        return ResponseEntity.ok(comproService.save(x));
    }

    // Actualiza
    @PutMapping("/{idcompromiso}")
    public Compromisos actualiza(@PathVariable Short idcompromiso, @RequestBody Compromisos x) {
        return comproService.actualiza(idcompromiso, x);
    }

    // Elimina
    @DeleteMapping("/{idcompromiso}")
    public ResponseEntity<Void> delete(@PathVariable("idcompromiso") Short idcompromiso) {
        comproService.deleteById(idcompromiso);
        return ResponseEntity.noContent().build();
    }

}

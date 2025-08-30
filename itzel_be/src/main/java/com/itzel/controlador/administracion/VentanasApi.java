package com.itzel.controlador.administracion;

import com.itzel.modelo.administracion.Ventanas;
import com.itzel.servicio.administracion.VentanaService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/ventanas")
@CrossOrigin("*")
public class VentanasApi {
    @Autowired
    private VentanaService venServicio;

    @GetMapping
    public Ventanas getAllLista(@Param(value = "idusuario") Long idusuario,
                                @Param(value = "nombre") String nombre) {
        if (idusuario != null && nombre != null) {
            return venServicio.findVentana(idusuario, nombre);
        } else {
            return null;
        }
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<Ventanas> save(@RequestBody Ventanas x) {
        return ResponseEntity.ok(venServicio.save(x));
    }

    @PutMapping("/{idventana}")
    public ResponseEntity<Ventanas> update(@PathVariable Long idventana, @RequestBody Ventanas x) {
        Ventanas y = venServicio.findById(idventana)
                .orElseThrow(() -> new EntityNotFoundException(
                        ("No existe la Ventana con Id: " + idventana)));
        y.setNombre(x.getNombre());
        y.setColor1(x.getColor1());
        y.setColor2(x.getColor2());
        y.setIdusuario(x.getIdusuario());

        Ventanas actualizar = venServicio.save(y);
        return ResponseEntity.ok(actualizar);
    }

}

package com.itzel.controlador.administracion;

import com.itzel.modelo.administracion.Eliminados;
import com.itzel.servicio.administracion.EliminadoService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/eliminados")
public class EliminadosApi {
    private final EliminadoService elimService;

    public EliminadosApi(EliminadoService elimService) {
        this.elimService = elimService;
    }

    // Guardar nuevo
    @PostMapping
    public Eliminados save(@RequestBody Eliminados eliminado) {
        return elimService.save(eliminado);
    }

}

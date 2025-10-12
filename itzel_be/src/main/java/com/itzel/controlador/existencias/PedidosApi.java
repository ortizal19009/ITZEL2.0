package com.itzel.controlador.existencias;

import com.itzel.servicio.existencias.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/pedidos")
@CrossOrigin("*")
public class PedidosApi {
    private final PedidoService pedidoService;
    //LISTAR TODOS LOS PEDIDOS

}

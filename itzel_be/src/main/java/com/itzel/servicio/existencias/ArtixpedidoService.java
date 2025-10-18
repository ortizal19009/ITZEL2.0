package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artixpedido;
import com.itzel.repositorio.existencias.ArticulosR;
import com.itzel.repositorio.existencias.ArtixpedidoR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ArtixpedidoService {
    private final ArtixpedidoR dao;

    public List<Artixpedido> findByIdpedido(short idpedido){
        return dao.findByPedido_Idpedido(idpedido);
    }

    public List<Artixpedido> findByIdarticulo(short idarticulo){
        return dao.findByArticulo_Idarticulo(idarticulo);
    }
    public Artixpedido save(Artixpedido ap){
        return dao.save(ap);
    }


}

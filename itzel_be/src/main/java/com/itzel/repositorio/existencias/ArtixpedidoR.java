package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Artixpedido;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArtixpedidoR extends JpaRepository<Artixpedido, Short> {
    List<Artixpedido> findByPedido_Idpedido(short idpedido);
    List<Artixpedido> findByArticulo_Idarticulo(short idarticulo);

}

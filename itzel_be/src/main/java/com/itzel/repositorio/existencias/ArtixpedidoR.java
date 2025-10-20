package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Artixpedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface ArtixpedidoR extends JpaRepository<Artixpedido, Short> {
    List<Artixpedido> findByPedido_Idpedido(short idpedido);
    List<Artixpedido> findByArticulo_Idarticulo(short idarticulo);
    Artixpedido findByPedido_IdpedidoAndArticulo_Idarticulo(short idpedido, short idarticulo);
    @Modifying
    @Query("DELETE FROM Artixpedido ap WHERE ap.pedido.idpedido = :idpedido AND ap.articulo.idarticulo IN :ids")
    int deleteAllByPedidoAndArticuloIds(@Param("idpedido") short idpedido, @Param("ids") Collection<Short> ids);

}

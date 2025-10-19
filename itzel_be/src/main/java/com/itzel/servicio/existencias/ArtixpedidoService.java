package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artixpedido;
import com.itzel.repositorio.existencias.ArticulosR;
import com.itzel.repositorio.existencias.ArtixpedidoR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ArtixpedidoService {
    private final ArtixpedidoR dao;
    private final ArticulosR dao_articulo;

    public List<Artixpedido> findByIdpedido(short idpedido){
        return dao.findByPedido_Idpedido(idpedido);
    }

    public List<Artixpedido> findByIdarticulo(short idarticulo){
        return dao.findByArticulo_Idarticulo(idarticulo);
    }
    @Transactional
    public Artixpedido save(Artixpedido ap) {
        // Verificar que el artículo exista
        Articulos articulo = dao_articulo.findById(ap.getArticulo().getIdarticulo())
                .orElseThrow(() -> new RuntimeException("Artículo no encontrado"));

        // Buscar si ya existe un registro del mismo artículo en el mismo pedido
        Artixpedido existente = dao.findByPedido_IdpedidoAndArticulo_Idarticulo(
                ap.getPedido().getIdpedido(),
                ap.getArticulo().getIdarticulo()
        );

        // Calcular la diferencia de cantidad (para ajustar inventario correctamente)
        BigDecimal cantidadAnterior = BigDecimal.ZERO;
        if (existente != null) {
            cantidadAnterior = BigDecimal.valueOf(existente.getCantidad());
        }

        BigDecimal cantidadNueva = BigDecimal.valueOf(ap.getCantidad());
        BigDecimal diferencia = cantidadNueva.subtract(cantidadAnterior);

        // Actualizar el stock del artículo (restar si es salida, sumar si se reduce cantidad)
        articulo.setActual(articulo.getActual().subtract(diferencia));
        dao_articulo.save(articulo);

        // Guardar nuevo o actualizar existente
        if (existente == null) {
            return dao.save(ap);
        } else {
            existente.setCantidad(ap.getCantidad());
            existente.setUsumodi(ap.getUsumodi());
            existente.setFecmodi(ap.getFecmodi());
            return dao.save(existente);
        }
    }

}

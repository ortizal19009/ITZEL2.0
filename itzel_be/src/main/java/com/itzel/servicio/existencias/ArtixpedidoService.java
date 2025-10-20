package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artixpedido;
import com.itzel.modelo.existencias.Pedidos;
import com.itzel.repositorio.existencias.ArticulosR;
import com.itzel.repositorio.existencias.ArtixpedidoR;
import com.itzel.repositorio.existencias.PedidosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class ArtixpedidoService {
    private final ArtixpedidoR dao;
    private final ArticulosR dao_articulo;
    private final PedidosR dao_pedido;

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
        Long cantidadAnterior = 0L;
        if (existente != null) {
            cantidadAnterior = existente.getCantidad();
        }

        Long cantidadNueva =ap.getCantidad();
        Long diferencia = cantidadNueva - cantidadAnterior;

        // Actualizar el stock del artículo (restar si es salida, sumar si se reduce cantidad)
        articulo.setActual(articulo.getActual()-(diferencia));
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

    public String update(short idpedido, Articulos articulo) {
        // Buscar si existe la relación Artixpedido
        Artixpedido ap = dao.findByPedido_IdpedidoAndArticulo_Idarticulo(idpedido, articulo.getIdarticulo());
        if (ap == null) {
            throw new RuntimeException("No se encontró Artixpedido para el pedido y artículo indicados");
        }

        // Obtener el artículo desde la base de datos
        Articulos _articulo = dao_articulo.findById(articulo.getIdarticulo())
                .orElseThrow(() -> new RuntimeException("Artículo no encontrado"));

        // Actualizar stock sumando la cantidad del pedido
        Long cantidadPedido = ap.getCantidad();
        _articulo.setActual(_articulo.getActual()+cantidadPedido);

        // Guardar cambios en la base
        dao_articulo.save(_articulo);

        return "Actualizado correctamente";
    }
    @Transactional
    public String updateAll(short idpedido, List<Articulos> nuevosArticulos) {
        if (nuevosArticulos == null) nuevosArticulos = List.of();
        Pedidos _p = dao_pedido.findById(idpedido).orElseThrow(()->new RuntimeException("Pedido no encontrado"));
        // Consolidar duplicados del input: idarticulo -> cantidad (Long)
        // Usa la CANTIDAD solicitada (no el stock 'actual')
        Map<Short, Long> nuevosPorId = nuevosArticulos.stream()
                .collect(Collectors.toMap(
                        Articulos::getIdarticulo,
                        a -> safeLong(a.getActual()),      // <-- cantidad pedida
                        Long::sum                             // si vienen repetidos, suma
                ));

        // Cargar líneas actuales del pedido
        List<Artixpedido> actuales = dao.findByPedido_Idpedido(idpedido);
        Map<Short, Artixpedido> actualesPorId = actuales.stream()
                .collect(Collectors.toMap(
                        ap -> ap.getArticulo().getIdarticulo(),
                        Function.identity()
                ));

        // 1) Eliminar los que desaparecen y devolver stock
        Set<Short> idsQueDesaparecen = actualesPorId.keySet().stream()
                .filter(id -> !nuevosPorId.containsKey(id))
                .collect(Collectors.toSet());

        for (Short artId : idsQueDesaparecen) {
            Artixpedido ap = actualesPorId.get(artId);
            Articulos art = getArticuloForUpdate(artId);  // ideal con lock pesimista
            Long devolver = safeLong(ap.getCantidad());   // cantidad a regresar

            art.setActual(art.getActual()+devolver);
            dao_articulo.save(art);
            dao.delete(ap);
        }

        // 2) Insertar/Actualizar lo que viene (ajustando stock por diferencia)
        for (Map.Entry<Short, Long> e : nuevosPorId.entrySet()) {
            Short artId    = e.getKey();
            Long  cantNueva = safeLong(e.getValue());

            Articulos art = getArticuloForUpdate(artId);
            Artixpedido existente = actualesPorId.get(artId);

            if (existente == null) {
                // Nuevo renglón en el pedido
                validarStock(BigDecimal.valueOf(art.getActual()), cantNueva, artId);
                Artixpedido apNuevo = new Artixpedido();
                apNuevo.setPedido(_p);
                apNuevo.setArticulo(art);
                apNuevo.setCantidad(cantNueva); // Long
                dao.save(apNuevo);

                art.setActual(art.getActual() - cantNueva);
                dao_articulo.save(art);

            } else {
                Long cantAntes = safeLong(existente.getCantidad());
                long delta = cantNueva - cantAntes; // >0: pide más; <0: devuelve

                if (delta != 0L) {
                    if (delta > 0L) {
                        validarStock(BigDecimal.valueOf(art.getActual()), delta, artId);
                        art.setActual(art.getActual() - delta);
                    } else { // delta < 0
                        art.setActual(art.getActual()+(-delta));
                    }
                    dao_articulo.save(art);

                    existente.setCantidad(cantNueva); // Long
                    dao.save(existente);
                }
            }
        }

        return "Artículos del pedido actualizados correctamente";
    }

    /* ===== Helpers ===== */

    private static Long safeLong(Number n) {
        return (n == null) ? 0L : n.longValue();
    }

    private void validarStock(BigDecimal stock, Long req, Short artId) {
        if (stock == null) stock = BigDecimal.ZERO;
        if (req == null || req < 0)
            throw new IllegalArgumentException("Cantidad inválida para artículo " + artId);

        BigDecimal requerido = BigDecimal.valueOf(req);
        if (stock.compareTo(requerido) < 0) {
            throw new IllegalStateException(
                    "Stock insuficiente para artículo " + artId +
                            " (stock=" + stock + ", requerido=" + requerido + ")"
            );
        }
    }

    /**
     * Ideal: método en el repositorio con @Lock(PESSIMISTIC_WRITE)
     * para evitar condiciones de carrera al ajustar stock.
     */
    private Articulos getArticuloForUpdate(Short artId) {
        return dao_articulo.findById(artId)
                .orElseThrow(() -> new RuntimeException("Artículo no encontrado: " + artId));
    }


}

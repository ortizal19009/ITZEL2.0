package com.itzel.servicio.existencias;

import com.itzel.DTO.existencias.ArticulosDTO;
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
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;
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
    public String updateAll(short idpedido, short usumodi, Timestamp fecmodi, List<ArticulosDTO> nuevosArticulos) {

        if (nuevosArticulos == null) nuevosArticulos = List.of();

        Pedidos pedido = dao_pedido.findById(idpedido)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado"));

        // Consolidar duplicados del input (idarticulo -> cantidad)
        Map<Short, Long> nuevosPorId = nuevosArticulos.stream()
                .filter(a -> a != null) // evita null keys
                .collect(Collectors.toMap(
                        ArticulosDTO::getIdarticulo,
                        a -> safeLong(a.getCantidad()), // cantidad pedida
                        Long::sum                     // si hay repetidos, suma
                ));



        // Cargar líneas actuales del pedido
        List<Artixpedido> actuales = dao.findByPedido_Idpedido(idpedido);
        Map<Short, Artixpedido> actualesPorId = actuales.stream()
                .collect(Collectors.toMap(
                        ap -> ap.getArticulo().getIdarticulo(),
                        Function.identity(),
                        (a1, a2) -> a1  // si hay duplicado, conserva el primero
                ));


        // --- 1) Eliminar artículos que ya no están en el pedido ---
        Set<Short> idsAEliminar = actualesPorId.keySet().stream()
                .filter(id -> !nuevosPorId.containsKey(id))
                .collect(Collectors.toSet());
        for (Short idArt : idsAEliminar) {
            Artixpedido ap = actualesPorId.get(idArt);
            if (ap == null) continue; // seguridad

            Articulos art = getArticuloForUpdate(idArt);
            long cantidadDevuelta = safeLong(ap.getCantidad());
            // Devolver stock
            art.setActual(art.getActual() + cantidadDevuelta);
            dao_articulo.save(art);
            // Eliminar relación Artixpedido
            dao.delete(ap);
        }
        // --- 2) Insertar o actualizar los artículos nuevos ---
        for (Map.Entry<Short, Long> e : nuevosPorId.entrySet()) {
            Short idArt = e.getKey();
            long cantidadNueva = e.getValue();
            Articulos art = getArticuloForUpdate(idArt);
            Artixpedido existente = actualesPorId.get(idArt);
            if (existente == null) {
                // Nuevo registro
                validarStock(BigDecimal.valueOf(art.getActual()), cantidadNueva, idArt);
                Artixpedido nuevo = new Artixpedido();
                nuevo.setPedido(pedido);
                nuevo.setArticulo(art);
                nuevo.setFeccrea(fecmodi);
                nuevo.setUsucrea((long) usumodi);
                nuevo.setCantidad(cantidadNueva);
                dao.save(nuevo);
                art.setActual(art.getActual() - cantidadNueva);
                dao_articulo.save(art);

            } else {
                long cantidadAnterior = safeLong(existente.getCantidad());
                long diferencia = cantidadNueva - cantidadAnterior;

                if (diferencia != 0L) {
                    if (diferencia > 0L) {
                        // Se pide más cantidad
                        validarStock(BigDecimal.valueOf(art.getActual()), diferencia, idArt);
                        art.setActual(art.getActual()-diferencia);
                    } else {
                        // Se devuelve parte del stock
                        art.setActual(art.getActual()+(-diferencia));
                    }

                    dao_articulo.save(art);
                    existente.setCantidad(cantidadNueva);
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

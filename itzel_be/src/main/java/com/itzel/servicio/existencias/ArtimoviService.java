package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artimovi;
import com.itzel.modelo.existencias.Movimientos;
import com.itzel.repositorio.existencias.ArtimoviR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ArtimoviService {
    private final ArtimoviR dao;
    public Artimovi save(Artimovi am){
        return dao.save(am);
    }
    public List<Artimovi> findByIdMovimiento(Long idmovimiento){
        return dao.findByIdMovimiento(idmovimiento);
    }
    @Transactional
    public String save(List<Articulos> articulos, Movimientos movimiento) {

        List<Artimovi> detalle = articulos.stream()
                .map(art -> {
                    Artimovi am = new Artimovi();
                    am.setMovimiento(movimiento);  // FK movimiento
                    am.setArticulo(art);           // FK artículo

                    // Valores que puedes setear según tu lógica
                    am.setCantidad(1); // ejemplo
                    am.setTotal(BigDecimal.ZERO);
                    am.setCosprom(BigDecimal.ZERO);
                    //am.setUsucrea(movimiento.getUsucrea());
                    am.setFeccrea(new Timestamp(System.currentTimeMillis()));

                    return am;
                })
                .toList();

        dao.saveAll(detalle);

        // Retornar mensaje personalizado
        int totalArticulos = detalle.size();
        return "Se registraron " + totalArticulos + " artículos en el movimiento #"
                + movimiento.getIdmovimiento();
    }
}

package com.itzel.servicio.existencias;

import com.itzel.DTO.existencias.ArtimoviDTO;
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
        return dao.findByMovimiento_Idmovimiento(idmovimiento);
    }

    @Transactional
    public void guardarMovimiento(ArtimoviDTO dto) {

        for (Articulos art : dto.getArticulos()) {

            Artimovi entidad = new Artimovi();

            entidad.setTipmov(dto.getTipmov());
            entidad.setCantidad(dto.getCantidad());
            entidad.setTotal(dto.getTotal());
            entidad.setCosprom(dto.getCosprom());
            entidad.setUsucrea(dto.getUsucrea());
            entidad.setFeccrea(dto.getFeccrea());
            entidad.setUsumodi(dto.getUsumodi());
            entidad.setFecmodi(dto.getFecmodi());

            entidad.setMovimiento(dto.getMovimiento());
            entidad.setArticulo(art);

            dao.save(entidad);
        }
    }
}

package com.itzel.servicio.existencias;

import com.itzel.DTO.existencias.ArtimoviRequestDTO;
import com.itzel.modelo.existencias.Articulos;
import com.itzel.modelo.existencias.Artimovi;
import com.itzel.modelo.existencias.Movimientos;
import com.itzel.repositorio.contabilidad.CuentasR;
import com.itzel.repositorio.existencias.ArticulosR;
import com.itzel.repositorio.existencias.ArtimoviR;
import com.itzel.repositorio.existencias.MovimientosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ArtimoviService {
    private final ArtimoviR dao;
    private final MovimientosR movimientosR;
    private final ArticulosR articulosR;
    private final CuentasR cuentasR;
    public Artimovi save(Artimovi am){
        return dao.save(am);
    }
    public List<Artimovi> findByIdMovimiento(Long idmovimiento){
        return dao.findByMovimiento_Idmovimiento(idmovimiento);
    }

    @Transactional
    public Short guardarMovimiento(ArtimoviRequestDTO dto) {

        if (dto.getMovimiento() == null || dto.getMovimiento().getIdmovimiento() == null) {
            throw new RuntimeException("movimiento es obligatorio");
        }
        if (dto.getArticulos() == null || dto.getArticulos().isEmpty()) {
            throw new RuntimeException("Debe enviar al menos un artículo");
        }

        // 1) movimiento existente
        Short idMov = dto.getMovimiento().getIdmovimiento();
        Movimientos mov = movimientosR.findById(idMov)
                .orElseThrow(() -> new RuntimeException("Movimiento no existe: " + idMov));

        Timestamp ahora = new Timestamp(System.currentTimeMillis());

        // 2) guardar artículos primero (pero con cuenta obligatoria)
        List<Articulos> articulosGuardados = dto.getArticulos().stream().map(aDto -> {

            // idcuenta OBLIGATORIO (por NOT NULL en BD)
            Long idCuenta = aDto.getCuenta().getIdcuenta();

            // Fallback si aún envías "cuenta" como objeto desde front (no recomendado)
            if (idCuenta == null && aDto.getCuenta() != null) {
                idCuenta = aDto.getCuenta().getIdcuenta();
            }

            if (idCuenta == null) {
                throw new RuntimeException("idcuenta es obligatorio para el artículo: " + aDto.getCodigo());
            }

            Articulos a = new Articulos();
            a.setCodigo(aDto.getCodigo());
            a.setNombre(aDto.getNombre());
            a.setCodcue(aDto.getCodcue());
            a.setUnidad(aDto.getUnidad());

            a.setInicial(aDto.getInicial());
            a.setCosinicial(aDto.getCosinicial());
            a.setActual(aDto.getActual());
            a.setCosactual(aDto.getCosactual());
            a.setCostotal(aDto.getCostotal());
            a.setDescripcion(aDto.getDescripcion());

            // en tu entity son primitivos float/boolean, evita null
            a.setMinimo(aDto.getMinimo() != null ? aDto.getMinimo() : 0f);
            a.setMaximo(aDto.getMaximo() != null ? aDto.getMaximo() : 0f);
            a.setSwinmediato(Boolean.TRUE.equals(aDto.getSwinmediato()));

            // ✅ auditoría: en tu entity usucrea es primitive short => NO puede quedar null
            short usuCrea = (dto.getUsucrea() != null ? dto.getUsucrea() : 1);
            Short usuModi = (dto.getUsumodi() != null ? dto.getUsumodi() : usuCrea);

            a.setUsucrea(usuCrea);
            a.setFeccrea(ahora);
            a.setUsumodi(usuModi);
            a.setFecmodi(null);

            // ✅ CLAVE: setear cuenta
            a.setCuenta(cuentasR.getReferenceById(idCuenta));

            return articulosR.save(a);
        }).toList();

        // 3) guardar Artimovi (detalle)
        List<Artimovi> lista = articulosGuardados.stream().map(art -> {
            Artimovi am = new Artimovi();

            am.setTipmov(dto.getTipmov());
            am.setCantidad(dto.getCantidad());
            am.setTotal(dto.getTotal());
            am.setCosprom(dto.getCosprom());

            am.setUsucrea(dto.getUsucrea());
            am.setFeccrea(dto.getFeccrea() != null ? dto.getFeccrea() : ahora);

            am.setUsumodi(dto.getUsumodi());
            am.setFecmodi(dto.getFecmodi() != null ? dto.getFecmodi() : ahora);

            am.setMovimiento(mov);
            am.setArticulo(art);

            return am;
        }).toList();

        dao.saveAll(lista);
        return idMov;
    }
}

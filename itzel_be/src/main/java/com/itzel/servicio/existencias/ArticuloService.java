package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Articulos;
import com.itzel.repositorio.existencias.ArticulosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ArticuloService {

    private final ArticulosR dao;

    // Buscar por código, codcue y nombre
    public List<Articulos> buscarPorFiltros(String codigo, String codcue, String nombre) {
        return dao.findByCodigoContainingIgnoreCaseAndCodcueStartingWithAndNombreContainingIgnoreCaseOrderByCodigoAsc(
                codigo, codcue, nombre);
    }

    // Validar nombre
    public boolean valNombre(String nombre) {
        return dao.existsByNombreIgnoreCase(nombre);
    }

    // Valida código
    public boolean valCodigo(String codigo) {
        return dao.existsByCodigo(codigo);
    }

    // Guarda nuevo
    public <S extends Articulos> S save(S entity) {
        return dao.save(entity);
    }

    // Buscar por idarticulo
    public Optional<Articulos> findById(Short idarticulo) {
        return dao.findById(idarticulo);
    }

    // Actualizar
    public Articulos actualizarArticulo(Short idarticulo, Articulos x) {
        Optional<Articulos> y = dao.findById(idarticulo);
        if (y.isPresent()) {
            Articulos articulo = y.get();
            articulo.setCodigo(x.getCodigo());
            articulo.setCodcue(x.getCodcue());
            articulo.setNombre(x.getNombre());
            articulo.setUnidad(x.getUnidad());
            articulo.setMinimo(x.getMinimo());
            articulo.setMaximo(x.getMaximo());
            articulo.setSwinmediato(x.isSwinmediato());
            articulo.setInicial(x.getInicial());
            articulo.setCosinicial(x.getCosinicial());
            articulo.setActual(x.getActual());
            articulo.setCosactual(x.getCosactual());
            articulo.setDescripcion(x.getDescripcion());

            articulo.setUsumodi(x.getUsumodi());
            articulo.setFecmodi(x.getFecmodi());

            articulo.setCuenta(x.getCuenta());

            return dao.save(articulo);
        } else {
            throw new RuntimeException("Articulo no encontrado con id " + idarticulo);
        }
    }

    //Elimina
    public void deleteById(Short idarticulo) {
        dao.deleteById(idarticulo);
    }

}


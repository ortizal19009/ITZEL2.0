package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Artimovi;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArtimoviR extends JpaRepository<Artimovi, Short> {
    List<Artimovi> findByMovimiento_Idmovimiento(Long idmovimiento);
}

package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Artimovi;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtimoviR extends JpaRepository<Artimovi, Short> {
    List<Artimovi> findByMovimiento_Idmovimiento(Long idmovimiento);


    @Modifying
    @Transactional
    @Query("delete from Artimovi a where a.movimiento.idmovimiento = :idmovimiento")
    void deleteByMovimiento(@Param("idmovimiento") Short idmovimiento);

    List<Artimovi> findByMovimiento_Idmovimiento(Short idmovimiento);
}

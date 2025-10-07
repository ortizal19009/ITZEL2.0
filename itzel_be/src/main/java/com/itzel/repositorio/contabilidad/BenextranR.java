package com.itzel.repositorio.contabilidad;


import com.itzel.modelo.contabilidad.Benextran;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BenextranR extends JpaRepository<Benextran, Long> {

    // Recupera por Transaccion
    List<Benextran> findByTransaccion_Idtransaccion(Long idtransaccion);

}

package com.itzel.jasperReports.services;

import com.itzel.jasperReports.modelo.Repoxopcion;
import com.itzel.jasperReports.repositories.RepoxopcionR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class RepoxopcionService {
    private final RepoxopcionR dao;

    // Repoxopcion para datalist
    public List<Repoxopcion> findRepoxopcionPorCodigo(String codigo) {
        return dao.findByCodigoStartingWithOrderByCodigo(codigo);
    }

    public List<Repoxopcion> findByCodigoEnd(String codigo){
        return dao.findByCodigoEndingWith(codigo);
    }
}

package com.itzel.jasperReports.repositories;

import com.itzel.jasperReports.modelo.Repoxopcion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RepoxopcionR extends JpaRepository<Repoxopcion, Short> {
    public List<Repoxopcion> findByCodigoEndingWith(String codigo);
    // Recupera registros cuyo código comienza por un código especifico
    // List<Repoxopcion> findByCodigoOrderByCodigo(String codigo);

    // Repoxopcion por Código para datalist
    List<Repoxopcion> findByCodigoStartingWithOrderByCodigo(String codigo);

}

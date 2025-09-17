package com.itzel.repositorio.administracion;

import com.itzel.modelo.administracion.Documentos;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DocumentosR extends JpaRepository<Documentos, Short> {
}

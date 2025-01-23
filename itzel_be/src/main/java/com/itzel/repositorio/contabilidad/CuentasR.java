package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Cuentas;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CuentasR extends JpaRepository<Cuentas, Long> {
}

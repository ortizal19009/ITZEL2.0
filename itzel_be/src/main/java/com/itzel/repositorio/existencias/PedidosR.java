package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Pedidos;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PedidosR extends JpaRepository<Pedidos, Short> {
}

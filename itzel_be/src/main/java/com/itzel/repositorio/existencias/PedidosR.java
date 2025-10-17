package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Pedidos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PedidosR extends JpaRepository<Pedidos, Short> {
    //Encontrar el último numero de los pedidos para generar el secuencial de los pedidos
    @Query("SELECT MAX(p.numero) FROM Pedidos p")
    Integer findUltimoNumero();

    public Pedidos findTopByOrderByNumeroDesc();

}

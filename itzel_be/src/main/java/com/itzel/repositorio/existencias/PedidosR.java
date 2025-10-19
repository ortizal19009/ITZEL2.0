package com.itzel.repositorio.existencias;

import com.itzel.modelo.existencias.Pedidos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PedidosR extends JpaRepository<Pedidos, Short> {
    //Encontrar el último numero de los pedidos para generar el secuencial de los pedidos
    @Query("SELECT MAX(p.numero) FROM Pedidos p")
    Integer findUltimoNumero();

    public Pedidos findTopByOrderByNumeroDesc();
    //Buscar si el numero esta disponible o no
    Pedidos findByNumero(Long numero);
    boolean existsByNumero(Long numero);
    List<Pedidos> findByFechaBetween(LocalDate start, LocalDate end);

    List<Pedidos> findByNumeroBetweenOrderByNumeroAsc(Long start, Long end);

    @Query("SELECT p FROM Pedidos p WHERE LOWER(p.descripcion) LIKE LOWER(CONCAT('%', :descripcion, '%'))")
    List<Pedidos> findByDescripcionIgnoreCase(@Param("descripcion") String descripcion);

    @Query("SELECT p FROM Pedidos p JOIN p.beneficiario b WHERE LOWER(b.nomben) LIKE LOWER(CONCAT('%', :nombene, '%'))")
    List<Pedidos> findByNombreBeneficiarioIgnoreCase(@Param("nombene") String nombene);
}
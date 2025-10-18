package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Pedidos;
import com.itzel.repositorio.existencias.PedidosR;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@RequiredArgsConstructor
@Service
public class PedidoService {
    private final PedidosR dao;
    //CREAR NUEVO
    public Pedidos save(Pedidos p){
        return dao.save(p);
    }
    //ENCONTRAR TODOS LOS PEDIDOS
    public List<Pedidos> findAll(){
        return dao.findAll();
    }
    /**
     * Buscar por ID
     */
    public Pedidos findById(Short idpedido){
        return dao.findById(idpedido).orElseThrow(()-> new RuntimeException("Pedido no encontrado con ese Id: "+ idpedido));
    }
    //ACTUALIZAR EL PEDIDO
    public Pedidos updatePedido(Pedidos p){
        Pedidos _p = dao.findById(p.getIdpedido()).orElseThrow(()->new RuntimeException("Pedido no encontrado, no se puede actualizar " + p.getIdpedido()));
        _p.setIdpedido(p.getIdpedido());
        _p.setNumero(p.getNumero());
        _p.setFecha(p.getFecha());
        _p.setTotal(p.getTotal());
        _p.setDescripcion(p.getDescripcion());
        _p.setUsucrea(p.getUsucrea());
        _p.setFeccrea(p.getFeccrea());
        _p.setUsumodi(p.getUsumodi());
        _p.setFecmodi(p.getFecmodi());
        _p.setBeneficiario(p.getBeneficiario());
        _p.setDestino(p.getDestino());
        _p.setNumdoc(p.getNumdoc());
        _p.setDocumento(p.getDocumento());
        return dao.save(_p);
    }
    //Encontrar el último numero de los pedidos para generar el secuencial de los pedidos
    public Integer findUltimoNumero(){
        Integer number = dao.findUltimoNumero();
        if(number == null || number == 0){
            number = 0;
        }
        return number;
    }


    /**
     * Buscar pedidos entre dos fechas
     */
    public List<Pedidos> buscarPorFecha(LocalDate inicio, LocalDate fin) {
        if (inicio == null || fin == null) {
            throw new IllegalArgumentException("Las fechas no pueden ser nulas");
        }
        return dao.findByFechaBetween(inicio, fin);
    }

    /**
     * Buscar pedidos entre dos números
     */
    public List<Pedidos> buscarPorNumero(Long inicio, Long fin) {
        if (inicio == null || fin == null) {
            throw new IllegalArgumentException("Los números no pueden ser nulos");
        }
        return dao.findByNumeroBetween(inicio, fin);
    }

    /**
     * Buscar pedidos por descripción (contiene)
     */
    public List<Pedidos> buscarPorDescripcion(String descripcion) {
        if (descripcion == null || descripcion.trim().isEmpty()) {
            return List.of();
        }
        return dao.findByDescripcionIgnoreCase(descripcion.trim());
    }

    /**
     * Buscar pedidos por nombre del beneficiario
     */
    public List<Pedidos> buscarPorNombreBeneficiario(String nombre) {
        if (nombre == null || nombre.trim().isEmpty()) {
            return List.of();
        }
        return dao.findByNombreBeneficiarioIgnoreCase(nombre.trim());
    }

    /**
     * Guardar o actualizar pedido
     */
    public Pedidos guardar(Pedidos pedido) {
        return dao.save(pedido);
    }

    /**
     * Obtener todos los pedidos
     */
    public List<Pedidos> listar() {
        return dao.findAll();
    }



    /**
     * Eliminar pedido
     */
    public void eliminar(short idpedido) {
        dao.deleteById(idpedido);
    }

    /**
     * Listar en formato pageable
     */
    public Page<Pedidos> listarPaginado(int page, int size, String sortBy, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase("desc") ? Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        return dao.findAll(pageable);
    }

}

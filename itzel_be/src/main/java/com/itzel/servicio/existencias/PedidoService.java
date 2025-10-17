package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Pedidos;
import com.itzel.repositorio.existencias.PedidosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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
    //ENCONTRAR UNO POR ID
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

}

package com.itzel.servicio.existencias;

import com.itzel.modelo.existencias.Movimientos;
import com.itzel.repositorio.existencias.MovimientosR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MovimientoService {
    private final MovimientosR dao;
    //Guardar nuevo movimiento
    public Movimientos save(Movimientos m){
        return dao.save(m);
    }
    //Buscar los movimientos por tipo de movimiento (ingreso ó salida)
    public List<Movimientos> findByTipmov(Short tipmov){
        return dao.findByTipmov(tipmov);
    }
    //Encontrar el último numero de los movimientos para generar el secuencial diferenciando ingresos y salidas
    public Integer findUltimoNumero(short tipmov){
        return dao.findUltimoNumero(tipmov);
    }
    //Verificar si existe el numero de movimiento por tipo y numero
    public boolean existsByTipoAndNumero(short tipmov, Long numero){
        return dao.existsByTipoAndNumero(tipmov, numero);
    }
    //GetAllMovimientos
    public List<Movimientos> getAllMovimientos(){
        return dao.findAll();
    }
    //GetMovimientoById
    public Movimientos findByIdMovimiento(Short idmov){
        return dao.findById(idmov).orElseThrow(()->new RuntimeException("Movimiento no encontrado"));
    }
    //Actualizar movimientos
    public Movimientos updateMovimiento(Movimientos m){
        Movimientos _m = dao.findById(m.getIdmovimiento()).orElseThrow(()->new RuntimeException("Movimiento no encontrado"));
        _m.setTipmov(m.getTipmov());
        _m.setNumero(m.getNumero());
        _m.setFecha(m.getFecha());
        _m.setNumentrada(m.getNumentrada());
        _m.setTotal(m.getTotal());
        _m.setNumart(m.getNumart());
        _m.setNumdoc(m.getNumdoc());
        _m.setFecdoc(m.getFecdoc());
        _m.setCompegre(m.getCompegre());
        _m.setSwaprobado(m.getSwaprobado());
        _m.setObservaciones(m.getObservaciones());
        _m.setUsucrea(m.getUsucrea());
        _m.setFeccrea(m.getFeccrea());
        _m.setUsumodi(m.getUsumodi());
        _m.setFecmodi(m.getFecmodi());
        _m.setDestino(m.getDestino());
        _m.setDocumento(m.getDocumento());
        _m.setBeneficiario(m.getBeneficiario());
        return dao.save(_m);
    }

}

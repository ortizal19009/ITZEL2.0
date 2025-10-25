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

}

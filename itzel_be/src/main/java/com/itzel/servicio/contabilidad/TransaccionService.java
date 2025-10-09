package com.itzel.servicio.contabilidad;

import com.itzel.DTO.AsientoDTO;
import com.itzel.DTO.SaveTxResponse;
import com.itzel.DTO.TransaccionDTO;
import com.itzel.modelo.contabilidad.Asientos;
import com.itzel.modelo.contabilidad.Beneficiarios;
import com.itzel.modelo.contabilidad.Cuentas;
import com.itzel.modelo.contabilidad.Transacciones;
import com.itzel.repositorio.contabilidad.AsientosR;
import com.itzel.repositorio.contabilidad.BeneficiariosR;
import com.itzel.repositorio.contabilidad.CuentasR;
import com.itzel.repositorio.contabilidad.TransaccionesR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.*;

@RequiredArgsConstructor
@Service
public class TransaccionService {
    private static final byte DEBE = 1;
    private static final byte HABER = 2;

    private final TransaccionesR dao;
    private final AsientosR dao_asientos;
    private final BeneficiariosR dao_beneficiarios;
    private final CuentasR dao_cuentas;

    // Transacciones por Asiento
    public List<Transacciones> obtenerPorIdAsiento(Short idasiento) {
        return dao.findByAsiento_IdasientoOrderByOrden(idasiento);
    }

    // Guarda nuevo
    public <S extends Transacciones> S save(S entity) {
        return dao.save(entity);
    }

    // Busca por idtransaccion
    public Optional<Transacciones> findById(Long idtransaccion) {
        return dao.findById(idtransaccion);
    }

    // Actualiza
    public Transacciones actualiza(Long idtransaccion, Transacciones x) {
        Optional<Transacciones> y = dao.findById(idtransaccion);
        if (y.isPresent()) {
            Transacciones transa = y.get();
            transa.setOrden(x.getOrden());
            transa.setTiptran(x.getTiptran());
            transa.setCodcue(x.getCodcue());

            transa.setDocumento(x.getDocumento());
            transa.setNumdoc(x.getNumdoc());
            transa.setDebcre(x.getDebcre());
            transa.setValor(x.getValor());
            transa.setConcepto(x.getConcepto());

            transa.setUsumodi(x.getUsumodi());
            transa.setFecmodi(x.getFecmodi());

            return dao.save(transa);
        } else {
            throw new RuntimeException("Transaccion no encontrada con id " + idtransaccion);
        }
    }


    // ======= GUARDAR/ACTUALIZAR TRANSACCIÓN =======
    @Transactional(rollbackFor = Exception.class)
    public SaveTxResponse guardarTransaccion(Transacciones t) {
        // … tus validaciones …

        // Persistir
        Transacciones saved = dao.save(t);

        // Recalcular totales
        RecalcResult rec = recalcAndUpdateAsiento(t.getAsiento().getIdasiento());

        // Mapear a DTOs (¡aquí NO devolvemos entidades!)
        TransaccionDTO txDTO = toTransaccionDTO(saved);
        AsientoDTO asDTO = new AsientoDTO(
                t.getAsiento().getIdasiento(),
                rec.deb(),
                rec.cre()
        );

        return new SaveTxResponse(txDTO, asDTO, rec.updated());
    }

    // ======= ELIMINAR TRANSACCIÓN =======
    @Transactional(rollbackFor = Exception.class)
    public SaveTxResponse eliminarTransaccion(Long idTransaccion) {
        Transacciones tx = dao.findById(idTransaccion)
                .orElseThrow(() -> new RuntimeException("La transacción no existe."));
        short idAsiento = tx.getAsiento().getIdasiento();

        dao.deleteById(idTransaccion);

        RecalcResult rec = recalcAndUpdateAsiento(idAsiento);

        // Aquí no hace falta devolver la transacción; puedes devolver null o un DTO mínimo
        AsientoDTO asDTO = new AsientoDTO(
                idAsiento,
                rec.deb(),
                rec.cre()
        );

        return new SaveTxResponse(null, asDTO, rec.updated());
    }

    // ---------- Helpers de mapeo ----------
    private TransaccionDTO toTransaccionDTO(Transacciones src) {
        return new TransaccionDTO(
                src.getIdtransaccion(),
                src.getAsiento().getIdasiento(),                 // solo ID (no navegues a más)
                src.getCuenta().getIdcuenta(),
                src.getBeneficiario().getIdbeneficiario(),
                new BigDecimal(String.valueOf(src.getValor())).setScale(2, RoundingMode.HALF_UP),
                getDebCreByte(src.getDebcre())
        );
    }
    // ======= UTILIDADES =======

    /** Recalcula totales DEBE/HABER del asiento y actualiza la tabla Asientos solo si cambian. */
    private RecalcResult recalcAndUpdateAsiento(short idAsiento) {
        BigDecimal deb = numToBD(dao.sumDebe(idAsiento));
        BigDecimal cre = numToBD(dao.sumHaber(idAsiento));

        int rows = dao_asientos.updateTotalesIfChanged(idAsiento, deb, cre);
        return new RecalcResult(deb, cre, rows > 0);
    }


    private BigDecimal numToBD(Object o) {
        if (o == null) return BigDecimal.ZERO.setScale(2);
        if (o instanceof BigDecimal bd) return bd.setScale(2, RoundingMode.HALF_UP);
        if (o instanceof BigInteger bi) return new BigDecimal(bi).setScale(2, RoundingMode.HALF_UP);
        if (o instanceof Number n)     return new BigDecimal(String.valueOf(n.doubleValue())).setScale(2, RoundingMode.HALF_UP);
        return BigDecimal.ZERO.setScale(2);
    }


    private BigDecimal toBigDecimal(float value) {
        return new BigDecimal(String.valueOf(value)).setScale(2, RoundingMode.HALF_UP);
    }



    private record RecalcResult(BigDecimal deb, BigDecimal cre, boolean updated) {}


    private BigDecimal nvl(BigDecimal v) {
        return (v == null) ? BigDecimal.ZERO.setScale(2) : v.setScale(2, RoundingMode.HALF_UP);
    }


    /** Normaliza Byte/byte/Number a byte, seguro ante null. */
    private byte getDebCreByte(Object debcre) {
        if (debcre == null) return 0;
        if (debcre instanceof Byte)   return ((Byte) debcre).byteValue();
        if (debcre instanceof Number) return ((Number) debcre).byteValue();
        if (debcre instanceof String) {
            try { return Byte.parseByte((String) debcre); } catch (NumberFormatException ignored) {}
        }
        return 0;
    }



}

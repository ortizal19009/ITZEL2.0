package com.itzel.modelo.contabilidad;

import com.itzel.modelo.administracion.Documentos;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name = "certificaciones")
public class Certificaciones {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idcertificacion;
    private int tipo;
    private int numero;
    private LocalDate fecha;
    private BigDecimal valor;
    private String descripcion;
    private String numdoc;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn (name = "idbeneficiario")
    private Beneficiarios beneficiario;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idbeneficiariores")
    private Beneficiarios beneficiariore;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn (name = "iddocumento")
    private Documentos documento;

    public Certificaciones() {
    }

    public Certificaciones(Long idcertificacion, int tipo, int numero, LocalDate fecha, BigDecimal valor, String descripcion, String numdoc, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi, Beneficiarios beneficiario, Beneficiarios beneficiariore, Documentos documento) {
        this.idcertificacion = idcertificacion;
        this.tipo = tipo;
        this.numero = numero;
        this.fecha = fecha;
        this.valor = valor;
        this.descripcion = descripcion;
        this.numdoc = numdoc;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
        this.beneficiario = beneficiario;
        this.beneficiariore = beneficiariore;
        this.documento = documento;
    }

    public Long getIdcertificacion() {
        return idcertificacion;
    }

    public void setIdcertificacion(Long idcertificacion) {
        this.idcertificacion = idcertificacion;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getNumdoc() {
        return numdoc;
    }

    public void setNumdoc(String numdoc) {
        this.numdoc = numdoc;
    }

    public Long getUsucrea() {
        return usucrea;
    }

    public void setUsucrea(Long usucrea) {
        this.usucrea = usucrea;
    }

    public LocalDate getFeccrea() {
        return feccrea;
    }

    public void setFeccrea(LocalDate feccrea) {
        this.feccrea = feccrea;
    }

    public Long getUsumodi() {
        return usumodi;
    }

    public void setUsumodi(Long usumodi) {
        this.usumodi = usumodi;
    }

    public LocalDate getFecmodi() {
        return fecmodi;
    }

    public void setFecmodi(LocalDate fecmodi) {
        this.fecmodi = fecmodi;
    }

    public Beneficiarios getBeneficiario() {
        return beneficiario;
    }

    public void setBeneficiario(Beneficiarios beneficiario) {
        this.beneficiario = beneficiario;
    }

    public Beneficiarios getBeneficiariore() {
        return beneficiariore;
    }

    public void setBeneficiariore(Beneficiarios beneficiariore) {
        this.beneficiariore = beneficiariore;
    }

    public Documentos getDocumento() {
        return documento;
    }

    public void setDocumento(Documentos documento) {
        this.documento = documento;
    }
}

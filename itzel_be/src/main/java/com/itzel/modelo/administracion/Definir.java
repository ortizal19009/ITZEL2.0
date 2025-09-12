package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;


import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "definir")
public class Definir {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long iddefinir;
    private String empresa;
    private String razonsocial;
    private String nombrecomercial;
    private String ruc;
    private String direccion;
    private Byte tipoambiente;
    private float iva;
    private LocalDate fechap;
    private String f_i;
    private String f_g;
    private Short longparing;
    private Short longpargas;

    public Definir() {
    }

    public Definir(Long iddefinir, String empresa, String razonsocial, String nombrecomercial, String ruc, String direccion, Byte tipoambiente, float iva, LocalDate fechap, String f_i, String f_g, Short longparing, Short longpargas) {
        this.iddefinir = iddefinir;
        this.empresa = empresa;
        this.razonsocial = razonsocial;
        this.nombrecomercial = nombrecomercial;
        this.ruc = ruc;
        this.direccion = direccion;
        this.tipoambiente = tipoambiente;
        this.iva = iva;
        this.fechap = fechap;
        this.f_i = f_i;
        this.f_g = f_g;
        this.longparing = longparing;
        this.longpargas = longpargas;
    }

    public Long getIddefinir() {
        return iddefinir;
    }

    public void setIddefinir(Long iddefinir) {
        this.iddefinir = iddefinir;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getRazonsocial() {
        return razonsocial;
    }

    public void setRazonsocial(String razonsocial) {
        this.razonsocial = razonsocial;
    }

    public String getNombrecomercial() {
        return nombrecomercial;
    }

    public void setNombrecomercial(String nombrecomercial) {
        this.nombrecomercial = nombrecomercial;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Byte getTipoambiente() {
        return tipoambiente;
    }

    public void setTipoambiente(Byte tipoambiente) {
        this.tipoambiente = tipoambiente;
    }

    public float getIva() {
        return iva;
    }

    public void setIva(float iva) {
        this.iva = iva;
    }

    public LocalDate getFechap() {
        return fechap;
    }

    public void setFechap(LocalDate fechap) {
        this.fechap = fechap;
    }

    public String getF_i() {
        return f_i;
    }

    public void setF_i(String f_i) {
        this.f_i = f_i;
    }

    public String getF_g() {
        return f_g;
    }

    public void setF_g(String f_g) {
        this.f_g = f_g;
    }

    public Short getLongparing() {
        return longparing;
    }

    public void setLongparing(Short longparing) {
        this.longparing = longparing;
    }

    public Short getLongpargas() {
        return longpargas;
    }

    public void setLongpargas(Short longpargas) {
        this.longpargas = longpargas;
    }
}

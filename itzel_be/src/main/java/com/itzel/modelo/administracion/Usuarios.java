package com.itzel.modelo.administracion;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZonedDateTime;

@Entity
@Getter
@Setter
@Table(name = "usuarios")
public class Usuarios {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idusuario;
    private String identificacion;
    private String codusu;
    private String nomusu;
    private LocalDate fdesde;
    private LocalDate fhasta;
    private String priusu;
    private String foto;
    private short modulo;
    private String alias;
    private boolean swmodulo1;
    private boolean swmodulo2;
    private boolean swmodulo3;
    private boolean swmodulo4;
    private boolean swmodulo5;
    private boolean swmodulo6;
    private Timestamp feccrea;
    private Timestamp fecmodi;
    private Long usumodi;
    private boolean msgval;
    private boolean swhabili;
    private boolean swmusica;

    public Usuarios() {
    }

    public Usuarios(Short idusuario, String identificacion, String codusu, String nomusu, LocalDate fdesde, LocalDate fhasta, String priusu, String foto, short modulo, String alias, boolean swmodulo1, boolean swmodulo2, boolean swmodulo3, boolean swmodulo4, boolean swmodulo5, boolean swmodulo6, Timestamp feccrea, Timestamp fecmodi, Long usumodi, boolean msgval, boolean swhabili, boolean swmusica) {
        this.idusuario = idusuario;
        this.identificacion = identificacion;
        this.codusu = codusu;
        this.nomusu = nomusu;
        this.fdesde = fdesde;
        this.fhasta = fhasta;
        this.priusu = priusu;
        this.foto = foto;
        this.modulo = modulo;
        this.alias = alias;
        this.swmodulo1 = swmodulo1;
        this.swmodulo2 = swmodulo2;
        this.swmodulo3 = swmodulo3;
        this.swmodulo4 = swmodulo4;
        this.swmodulo5 = swmodulo5;
        this.swmodulo6 = swmodulo6;
        this.feccrea = feccrea;
        this.fecmodi = fecmodi;
        this.usumodi = usumodi;
        this.msgval = msgval;
        this.swhabili = swhabili;
        this.swmusica = swmusica;
    }

    public Short getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Short idusuario) {
        this.idusuario = idusuario;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getCodusu() {
        return codusu;
    }

    public void setCodusu(String codusu) {
        this.codusu = codusu;
    }

    public String getNomusu() {
        return nomusu;
    }

    public void setNomusu(String nomusu) {
        this.nomusu = nomusu;
    }

    public LocalDate getFdesde() {
        return fdesde;
    }

    public void setFdesde(LocalDate fdesde) {
        this.fdesde = fdesde;
    }

    public LocalDate getFhasta() {
        return fhasta;
    }

    public void setFhasta(LocalDate fhasta) {
        this.fhasta = fhasta;
    }

    public String getPriusu() {
        return priusu;
    }

    public void setPriusu(String priusu) {
        this.priusu = priusu;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public short getModulo() {
        return modulo;
    }

    public void setModulo(short modulo) {
        this.modulo = modulo;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public boolean isSwmodulo1() {
        return swmodulo1;
    }

    public void setSwmodulo1(boolean swmodulo1) {
        this.swmodulo1 = swmodulo1;
    }

    public boolean isSwmodulo2() {
        return swmodulo2;
    }

    public void setSwmodulo2(boolean swmodulo2) {
        this.swmodulo2 = swmodulo2;
    }

    public boolean isSwmodulo3() {
        return swmodulo3;
    }

    public void setSwmodulo3(boolean swmodulo3) {
        this.swmodulo3 = swmodulo3;
    }

    public boolean isSwmodulo4() {
        return swmodulo4;
    }

    public void setSwmodulo4(boolean swmodulo4) {
        this.swmodulo4 = swmodulo4;
    }

    public boolean isSwmodulo5() {
        return swmodulo5;
    }

    public void setSwmodulo5(boolean swmodulo5) {
        this.swmodulo5 = swmodulo5;
    }

    public boolean isSwmodulo6() {
        return swmodulo6;
    }

    public void setSwmodulo6(boolean swmodulo6) {
        this.swmodulo6 = swmodulo6;
    }

    public Timestamp getFeccrea() {
        return feccrea;
    }

    public void setFeccrea(Timestamp feccrea) {
        this.feccrea = feccrea;
    }

    public Timestamp getFecmodi() {
        return fecmodi;
    }

    public void setFecmodi(Timestamp fecmodi) {
        this.fecmodi = fecmodi;
    }

    public Long getUsumodi() {
        return usumodi;
    }

    public void setUsumodi(Long usumodi) {
        this.usumodi = usumodi;
    }

    public boolean isMsgval() {
        return msgval;
    }

    public void setMsgval(boolean msgval) {
        this.msgval = msgval;
    }

    public boolean isSwhabili() {
        return swhabili;
    }

    public void setSwhabili(boolean swhabili) {
        this.swhabili = swhabili;
    }

    public boolean isSwmusica() {
        return swmusica;
    }

    public void setSwmusica(boolean swmusica) {
        this.swmusica = swmusica;
    }
}
package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Table(name = "eliminados")

public class Eliminados {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ideliminado;

    private short idusuario;
    private short modulo;
    private Timestamp fecha;
    private String routerlink;
    private String tabla;
    private String datos;

    public Eliminados(Long ideliminado, short idusuario, short modulo, Timestamp fecha, String routerlink, String tabla, String datos) {
        this.ideliminado = ideliminado;
        this.idusuario = idusuario;
        this.modulo = modulo;
        this.fecha = fecha;
        this.routerlink = routerlink;
        this.tabla = tabla;
        this.datos = datos;
    }

    public Eliminados() {
    }

    public Long getIdeliminado() {
        return ideliminado;
    }

    public void setIdeliminado(Long ideliminado) {
        this.ideliminado = ideliminado;
    }

    public short getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(short idusuario) {
        this.idusuario = idusuario;
    }

    public short getModulo() {
        return modulo;
    }

    public void setModulo(short modulo) {
        this.modulo = modulo;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public String getRouterlink() {
        return routerlink;
    }

    public void setRouterlink(String routerlink) {
        this.routerlink = routerlink;
    }

    public String getTabla() {
        return tabla;
    }

    public void setTabla(String tabla) {
        this.tabla = tabla;
    }

    public String getDatos() {
        return datos;
    }

    public void setDatos(String datos) {
        this.datos = datos;
    }
}

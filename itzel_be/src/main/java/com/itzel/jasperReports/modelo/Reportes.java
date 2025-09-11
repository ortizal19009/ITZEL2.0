package com.itzel.jasperReports.modelo;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "reportes")
@Getter
@Setter
@Builder
public class Reportes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idreporte;

    @Column(nullable = false, unique = true, length = 100)
    private String nombre;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    // Guardamos los binarios de los archivos
    @Lob
    @Column(name = "archivo_jrxml")
    private byte[] archivoJrxml;

    @Lob
    @Column(name = "archivo_jasper")
    private byte[] archivoJasper;

    // Parámetros dinámicos (almacenados como JSON en PostgreSQL)
    @Column(columnDefinition = "jsonb")
    //@Column(columnDefinition = "TEXT") // Para almacenar JSON de parámetros
    private String parametros;

    @Column(name = "creado", updatable = false)
    private LocalDateTime creado = LocalDateTime.now();

    public Reportes() {
    }

    public Reportes(Long idreporte, String nombre, String descripcion, byte[] archivoJrxml, byte[] archivoJasper, String parametros, LocalDateTime creado) {
        this.idreporte = idreporte;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.archivoJrxml = archivoJrxml;
        this.archivoJasper = archivoJasper;
        this.parametros = parametros;
        this.creado = creado;
    }

    public Long getIdreporte() {
        return idreporte;
    }

    public void setIdreporte(Long idreporte) {
        this.idreporte = idreporte;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public byte[] getArchivoJrxml() {
        return archivoJrxml;
    }

    public void setArchivoJrxml(byte[] archivoJrxml) {
        this.archivoJrxml = archivoJrxml;
    }

    public byte[] getArchivoJasper() {
        return archivoJasper;
    }

    public void setArchivoJasper(byte[] archivoJasper) {
        this.archivoJasper = archivoJasper;
    }

    public String getParametros() {
        return parametros;
    }

    public void setParametros(String parametros) {
        this.parametros = parametros;
    }

    public LocalDateTime getCreado() {
        return creado;
    }

    public void setCreado(LocalDateTime creado) {
        this.creado = creado;
    }
}

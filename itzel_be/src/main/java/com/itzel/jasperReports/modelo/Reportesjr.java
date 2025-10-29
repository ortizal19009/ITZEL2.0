package com.itzel.jasperReports.modelo;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.Type;

import java.sql.Types;
import java.time.LocalDateTime;
import java.util.Map;
import com.vladmihalcea.hibernate.type.json.JsonType;


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

    @JdbcTypeCode(Types.BINARY)
    @Column(name = "archivo_jasper")
    private byte[] archivoJasper;

    @JdbcTypeCode(Types.BINARY)
    @Column(name = "archivo_jrxml")
    private byte[] archivoJrxml;

    @Type(JsonType.class) // 👈 Esto hace que maneje JSONB correctamente
    @Column(columnDefinition = "jsonb")
    private Map<String, Object> parametros;  // O JsonNode si prefieres

    @Column(name = "creado", updatable = false)
    private LocalDateTime creado = LocalDateTime.now();

    public Reportes() {
    }

    public Reportes(Long idreporte, String nombre, String descripcion, byte[] archivoJasper, byte[] archivoJrxml, Map<String, Object> parametros, LocalDateTime creado) {
        this.idreporte = idreporte;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.archivoJasper = archivoJasper;
        this.archivoJrxml = archivoJrxml;
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

    public Map<String, Object> getParametros() {
        return parametros;
    }

    public void setParametros(Map<String, Object> parametros) {
        this.parametros = parametros;
    }

    public LocalDateTime getCreado() {
        return creado;
    }

    public void setCreado(LocalDateTime creado) {
        this.creado = creado;
    }
}

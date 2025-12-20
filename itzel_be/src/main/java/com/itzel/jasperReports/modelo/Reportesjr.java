package com.itzel.jasperReports.modelo;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Type;

import java.sql.Timestamp;

import com.vladmihalcea.hibernate.type.json.JsonType;

@Entity
@Table(name = "reportesjr")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Reportesjr {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short idreporte;

    @Column(nullable = false, length = 50, unique = true)
    private String nomrep;

    @Column(nullable = false, length = 100)
    private String desrep;

    @Column(name = "jrxml", nullable = false)
    private byte[] jrxml;

    @Column(name = "jasper", nullable = false)
    private byte[] jasper;

    @Type(JsonType.class)
    @Column(columnDefinition = "json")
    private JsonNode parametros;

    @Column(nullable = false, updatable = false)
    private Timestamp feccrea;

    private Timestamp fecmodi;

    @PrePersist
    protected void onCreate() {
        feccrea = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        fecmodi = new Timestamp(System.currentTimeMillis());
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idrepoxopcion")
    private Repoxopcion repoxopcion;
    private short metodo;



}

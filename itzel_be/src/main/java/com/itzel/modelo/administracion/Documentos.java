package com.itzel.modelo.administracion;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name = "documentos")
public class Documentos {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short iddocumento;
    private String nomdoc;
    private int tipdoc;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idtabla4")
    private Tabla4 tabla4;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

    public Documentos() {
    }

    public Documentos(Short iddocumento, String nomdoc, int tipdoc, Tabla4 tabla4, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi) {
        this.iddocumento = iddocumento;
        this.nomdoc = nomdoc;
        this.tipdoc = tipdoc;
        this.tabla4 = tabla4;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Short getIddocumento() {
        return iddocumento;
    }

    public void setIddocumento(Short iddocumento) {
        this.iddocumento = iddocumento;
    }

    public String getNomdoc() {
        return nomdoc;
    }

    public void setNomdoc(String nomdoc) {
        this.nomdoc = nomdoc;
    }

    public int getTipdoc() {
        return tipdoc;
    }

    public void setTipdoc(int tipdoc) {
        this.tipdoc = tipdoc;
    }

    public Tabla4 getTabla4() {
        return tabla4;
    }

    public void setTabla4(Tabla4 tabla4) {
        this.tabla4 = tabla4;
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
}

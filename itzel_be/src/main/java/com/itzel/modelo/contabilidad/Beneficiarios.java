package com.itzel.modelo.contabilidad;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
@Entity
@Getter
@Setter
@Table(name = "beneficiarios")
public class Beneficiarios {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idbene;
    private String codben;
    private String nomben;
    private String tpidben;
    private String rucben;
    private String ciben;
    private String tlfben;
    private String dirben;
    private String mailben;
    private Long tpcueben;
    private String cuebanben;
    private String foto;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idgrupo")
    private Gruposbene grupo;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idifinan")
    private Ifinan ifinan;
    private Long swconsufin;
    private Integer modulo;
    private Long usucrea;
    private LocalDate feccrea;
    private Long usumodi;
    private LocalDate fecmodi;

    public Beneficiarios() {
    }

    public Beneficiarios(Long idbene, String codben, String nomben, String tpidben, String rucben, String ciben, String tlfben, String dirben, String mailben, Long tpcueben, String cuebanben, String foto, Gruposbene grupo, Ifinan ifinan, Long swconsufin, Integer modulo, Long usucrea, LocalDate feccrea, Long usumodi, LocalDate fecmodi) {
        this.idbene = idbene;
        this.codben = codben;
        this.nomben = nomben;
        this.tpidben = tpidben;
        this.rucben = rucben;
        this.ciben = ciben;
        this.tlfben = tlfben;
        this.dirben = dirben;
        this.mailben = mailben;
        this.tpcueben = tpcueben;
        this.cuebanben = cuebanben;
        this.foto = foto;
        this.grupo = grupo;
        this.ifinan = ifinan;
        this.swconsufin = swconsufin;
        this.modulo = modulo;
        this.usucrea = usucrea;
        this.feccrea = feccrea;
        this.usumodi = usumodi;
        this.fecmodi = fecmodi;
    }

    public Long getIdbene() {
        return idbene;
    }

    public void setIdbene(Long idbene) {
        this.idbene = idbene;
    }

    public String getCodben() {
        return codben;
    }

    public void setCodben(String codben) {
        this.codben = codben;
    }

    public String getNomben() {
        return nomben;
    }

    public void setNomben(String nomben) {
        this.nomben = nomben;
    }

    public String getTpidben() {
        return tpidben;
    }

    public void setTpidben(String tpidben) {
        this.tpidben = tpidben;
    }

    public String getRucben() {
        return rucben;
    }

    public void setRucben(String rucben) {
        this.rucben = rucben;
    }

    public String getCiben() {
        return ciben;
    }

    public void setCiben(String ciben) {
        this.ciben = ciben;
    }

    public String getTlfben() {
        return tlfben;
    }

    public void setTlfben(String tlfben) {
        this.tlfben = tlfben;
    }

    public String getDirben() {
        return dirben;
    }

    public void setDirben(String dirben) {
        this.dirben = dirben;
    }

    public String getMailben() {
        return mailben;
    }

    public void setMailben(String mailben) {
        this.mailben = mailben;
    }

    public Long getTpcueben() {
        return tpcueben;
    }

    public void setTpcueben(Long tpcueben) {
        this.tpcueben = tpcueben;
    }

    public String getCuebanben() {
        return cuebanben;
    }

    public void setCuebanben(String cuebanben) {
        this.cuebanben = cuebanben;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public Gruposbene getGrupo() {
        return grupo;
    }

    public void setGrupo(Gruposbene grupo) {
        this.grupo = grupo;
    }

    public Ifinan getIfinan() {
        return ifinan;
    }

    public void setIfinan(Ifinan ifinan) {
        this.ifinan = ifinan;
    }

    public Long getSwconsufin() {
        return swconsufin;
    }

    public void setSwconsufin(Long swconsufin) {
        this.swconsufin = swconsufin;
    }

    public Integer getModulo() {
        return modulo;
    }

    public void setModulo(Integer modulo) {
        this.modulo = modulo;
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

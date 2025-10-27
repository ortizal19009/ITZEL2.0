package com.itzel.repositorio.contabilidad;

import com.itzel.modelo.contabilidad.Beneficiarios;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BeneficiariosR extends JpaRepository<Beneficiarios, Long> {

    @Query(value = "SELECT * FROM beneficiarios WHERE LOWER(nomben) LIKE %?1% and codben LIKE %?2% and (rucben LIKE ?3% OR ciben LIKE ?4%) and idbeneficiario > 1 order by nomben", nativeQuery = true)
    public List<Beneficiarios> findBeneficiarios(String nomben, String codben, String rucben, String ciben);

    @Query(value = "SELECT * FROM beneficiarios WHERE LOWER(nomben) LIKE %?1% order by nomben", nativeQuery = true)
    public List<Beneficiarios> findByNomben(String nomben);
    @Query(value = "SELECT * FROM Beneficiarios WHERE LOWER(nomben) LIKE %?1% AND idgrupo = ?2  order by nomben", nativeQuery = true)
    public List<Beneficiarios> findByNombenGru(String nomben, Long idgrupo);

    @Query("SELECT COUNT(b) > 0 FROM Beneficiarios b WHERE LOWER(b.nomben) = :nomben")
    boolean valNomben(@Param("nomben") String nomben);

    @Query(value = "SELECT * FROM beneficiarios where idgrupo=?1 ORDER BY codben DESC LIMIT 1", nativeQuery = true)
    Beneficiarios findUltCodigo(Long idgrupo);

    @Query("SELECT COUNT(b) > 0 FROM Beneficiarios b WHERE b.codben = :codben")
    boolean valCodben(@Param("codben") String codben);

    @Query("SELECT COUNT(b) > 0 FROM Beneficiarios b WHERE b.rucben =:rucben")
    boolean valRucben(@Param("rucben") String rucben);

    @Query("SELECT COUNT(b) > 0 FROM Beneficiarios b WHERE b.ciben =:ciben")
    boolean valCiben(@Param("ciben") String ciben);

    @Query(value = "SELECT count(*) FROM beneficiarios where idifinan=?1", nativeQuery = true)
    Long countByIdifinan(Long idifinan);

    List<Beneficiarios> findByCodbenStartingWith(String prefix);

    List<Beneficiarios> findByCodbenStartingWithIgnoreCaseAndNombenContainingIgnoreCase(String codbenPrefix, String nomben);

}

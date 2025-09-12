package com.itzel.repositorio.administracion;

import com.itzel.modelo.administracion.Usuarios;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UsuariosR extends JpaRepository<Usuarios, Long> {
    // Todos (Excepto el Administrador)
    @Query(value = "SELECT * FROM usuarios order by identificacion", nativeQuery = true)
    List<Usuarios> findAll();

    // Busca un usuario por Identificación
    @Query(value = "SELECT * FROM usuarios where identificacion=?1", nativeQuery = true)
    Usuarios findByIdentificausu(String identificausu);

    @Query(value = "SELECT * FROM usuarios where identificacion=?1 AND codusu=?2", nativeQuery = true)
    Usuarios findUsuario(String a, String b);

}

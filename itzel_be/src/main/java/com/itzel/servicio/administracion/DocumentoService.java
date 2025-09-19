package com.itzel.servicio.administracion;

import com.itzel.modelo.administracion.Documentos;
import com.itzel.repositorio.administracion.DocumentosR;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DocumentoService {
    @Autowired
    private DocumentosR documentosR;
    public Object save(Documentos d){
        return documentosR.save(d);
    }
    public List<Documentos> findAll(){
        return documentosR.findAll(Sort.by(Sort.Direction.ASC, "iddocumento"));
    }
}

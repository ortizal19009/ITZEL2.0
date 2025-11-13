package com.itzel.servicio.existencias;

import com.itzel.repositorio.existencias.ArtimoviR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ArtimoviService {
    private final ArtimoviR dao;
}

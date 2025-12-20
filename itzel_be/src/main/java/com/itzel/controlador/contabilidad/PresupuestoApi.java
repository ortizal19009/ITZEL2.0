package com.itzel.controlador.contabilidad;

import com.itzel.DTO.contabilidad.AuxingresoReporte;
import com.itzel.jasperReports.DTO.JasperDatasetDTO;
import com.itzel.jasperReports.services.ReporteDatasetService;
import com.itzel.modelo.contabilidad.Presupuesto;
import com.itzel.servicio.contabilidad.PresupuestoService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@RestController
@RequestMapping("/presupuesto")
@CrossOrigin("*")
public class PresupuestoApi {

    private final PresupuestoService presuService;
    // Servicio para Dataset
    private final ReporteDatasetService reporteDatasetService;

    // Busca Partidas
    @GetMapping("/busca")
    public ResponseEntity<List<Presupuesto>> buscarPartidas(@RequestParam String codigo, @RequestParam short tippar,
                                                            @RequestParam String codpar, @RequestParam String nompar) {
        List<Presupuesto> resultados = presuService.buscarPartidasPorCampos(codigo, tippar, codpar, nompar);
        return ResponseEntity.ok(resultados);
    }

    // Valida códpar por proyecto
    @GetMapping("/valcodpar/{codpar}/{idproyecto}")
    public ResponseEntity<Boolean> valCodparPorProyecto(@PathVariable String codpar, @PathVariable Short idproyecto) {
        boolean existe = presuService.valCodparPorProyecto(codpar, idproyecto);
        return ResponseEntity.ok(existe);
    }

    // Valida nompar por proyecto
    @GetMapping("/valnompar/{nompar}/{idproyecto}")
    public ResponseEntity<Boolean> valNomparPorProyecto(@PathVariable String nompar, @PathVariable Short idproyecto) {
        boolean existe = presuService.valNomparPorProyecto(nompar, idproyecto);
        return ResponseEntity.ok(existe);
    }

    // Cuenta por idclasificador
    @GetMapping("/countidclasificador/{idclasificador}")
    public ResponseEntity<Short> cuentaPartidasPorClasificador(@PathVariable short idclasificador) {
        short cantidad = presuService.cuentaPartidasPorClasificador(idclasificador);
        return ResponseEntity.ok(cantidad);
    }

    // Conteo por idproyecto
    @GetMapping("/countidproyecto/{idproyecto}")
    public ResponseEntity<Short> cuentaPorProyecto(@PathVariable short idproyecto) {
        short cantidad = presuService.cuentaPorProyecto(idproyecto);
        return ResponseEntity.ok(cantidad);
    }

    // Partidas para datalist
    @GetMapping("/datalist")
    public List<Presupuesto> filtrarPresupuestos(
            @RequestParam Short tippar,
            @RequestParam String codpar) {
        return presuService.obtenerPresupuestosPorTipoyCodigo(tippar, codpar);
    }

    // Partidas para ng-select
    @GetMapping("/ngselect")
    public List<Presupuesto> obtenerPresupuestoPorTipo(@RequestParam Short tippar) {
        return presuService.obtenerPresupuestoPorTipo(tippar);
    }

    @GetMapping("/buscacodpar")
    public ResponseEntity<Presupuesto> buscarPorProyectoYCodpar(
            @RequestParam Short idproyecto,
            @RequestParam String codpar) {
        return presuService.buscarPorProyectoYCodpar(idproyecto, codpar)
                .map(ResponseEntity::ok) // si existe → 200 OK
                .orElseGet(() -> ResponseEntity.noContent().build()); // si no existe → 204 No Content
    }

    // Verifica existencia por codpar
    @GetMapping("/existe/{codpar}")
    public ResponseEntity<Boolean> existePorCodpar(@PathVariable String codpar) {
        boolean existe = presuService.existePorCodpar(codpar);
        return ResponseEntity.ok(existe);
    }

    // Guarda nuevo
    @PostMapping
    public Presupuesto save(@RequestBody Presupuesto partida) {
        return presuService.save(partida);
    }

    // Busca por idpresupuesto
    @GetMapping("/{idpresupuesto}")
    public ResponseEntity<Presupuesto> getByIdPresupuesto(@PathVariable Short idpresupuesto) {
        Presupuesto partida = presuService.findById(idpresupuesto)
                .orElseThrow();
        return ResponseEntity.ok(partida);
    }

    // Actualiza
    @PutMapping("/{idpresupuesto}")
    public Presupuesto actualiza(@PathVariable Short idpresupuesto, @RequestBody Presupuesto x) {
        return presuService.actualiza(idpresupuesto, x);
    }

    // Elimina
    @DeleteMapping("/{idpresupuesto}")
    public ResponseEntity<Void> delete(@PathVariable("idpresupuesto") Short idpresupuesto) {
        presuService.deleteById(idpresupuesto);
        return ResponseEntity.noContent().build();
    }

   /* @PostMapping("/dataset")
    public ResponseEntity<byte[]> generaPreingresos(
            @RequestBody JasperDatasetDTO<PreingresosReporte> dto) {
        return generar(dto);
    }*/

    @PostMapping("/auxingreso/dataset")
    public ResponseEntity<byte[]> generaAuxingreso(
            @RequestBody JasperDatasetDTO<AuxingresoReporte> dto) {
        return generar(dto);
    }

    private <T> ResponseEntity<byte[]> generar(JasperDatasetDTO<T> dto) {
        try {
            byte[] reporteBytes = reporteDatasetService.generarReporte(dto);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(getMediaType(dto.getExtension()));
            headers.setContentDisposition(ContentDisposition.builder("inline")
                    .filename(dto.getReportName() + "." + dto.getExtension())
                    .build());

            return new ResponseEntity<>(reporteBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Reporte partidas de ingresos
    // @PostMapping("/dataset")
    // public ResponseEntity<byte[]> generaPreingresos(@RequestBody JasperDatasetDTO<PreingresosReporte> dto) {
    //    try {
    //       byte[] reporteBytes = reporteDatasetService.generaPreingresos(dto);

    //       HttpHeaders headers = new HttpHeaders();
    //       headers.setContentType(getMediaType(dto.getExtension()));
    //       headers.setContentDisposition(ContentDisposition.builder("inline")
    //             .filename(dto.getReportName() + "." + dto.getExtension())
    //             .build());

    //       return new ResponseEntity<>(reporteBytes, headers, HttpStatus.OK);

    //    } catch (Exception e) {
    //       e.printStackTrace();
    //       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    //    }
    // }

    // // Reporte auxingreso
    // @PostMapping("/auxingreso/dataset")
    // public ResponseEntity<byte[]> generaAuxingreso(@RequestBody JasperDatasetDTO<AuxingresoReporte> dto) {
    //    try {
    //       byte[] reporteBytes = reporteDatasetService.generaAuxingreso(dto);

    //       HttpHeaders headers = new HttpHeaders();
    //       headers.setContentType(getMediaType(dto.getExtension()));
    //       headers.setContentDisposition(ContentDisposition.builder("inline")
    //             .filename(dto.getReportName() + "." + dto.getExtension())
    //             .build());

    //       return new ResponseEntity<>(reporteBytes, headers, HttpStatus.OK);

    //    } catch (Exception e) {
    //       e.printStackTrace();
    //       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    //    }
    // }

    private MediaType getMediaType(String extension) {
        if (extension == null)
            return MediaType.APPLICATION_OCTET_STREAM;

        switch (extension.toLowerCase()) {
            case "pdf":
                return MediaType.APPLICATION_PDF;
            case "xlsx":
                // application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
                return MediaType.parseMediaType(
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            case "xls":
                return MediaType.parseMediaType("application/vnd.ms-excel");
            case "docx":
                // application/vnd.openxmlformats-officedocument.wordprocessingml.document
                return MediaType.parseMediaType(
                        "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
            case "csv":
                return MediaType.parseMediaType("text/csv");
            case "html":
                return MediaType.TEXT_HTML;
            case "rtf":
                return MediaType.parseMediaType("application/rtf");
            case "xml":
                return MediaType.APPLICATION_XML;
            case "json":
                return MediaType.APPLICATION_JSON;
            default:
                // Fallback genérico
                return MediaType.APPLICATION_OCTET_STREAM;
        }
    }

}
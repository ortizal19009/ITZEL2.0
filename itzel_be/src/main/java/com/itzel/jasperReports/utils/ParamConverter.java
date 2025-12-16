package com.itzel.jasperReports.utils;

import com.itzel.jasperReports.DTO.ReportParameterDTO;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ParamConverter {

    public Map<String, Object> convert(List<ReportParameterDTO> list) {
        Map<String, Object> map = new HashMap<>();

        if (list == null)
            return map;

        for (ReportParameterDTO p : list) {
            map.put(p.getName(), p.getValue());
        }

        return map;
    }
}

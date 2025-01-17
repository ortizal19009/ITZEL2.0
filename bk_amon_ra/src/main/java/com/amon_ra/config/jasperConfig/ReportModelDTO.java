package com.amon_ra.config.jasperConfig;

import java.io.ByteArrayInputStream;

/**
 *
 * @author <a href="mailto:epmapat@gmail.com">Epmapa-T</a>
 * @project demo-spring-boot-jasper
 * @class ReportModelDTO
 * @description
 * @HU_CU_REQ
 * @date 24 sep. 2021
 */
public class ReportModelDTO {
    private String fileName;
    private ByteArrayInputStream stream;
    private int length;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public ByteArrayInputStream getStream() {
        return stream;
    }

    public void setStream(ByteArrayInputStream stream) {
        this.stream = stream;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }
}

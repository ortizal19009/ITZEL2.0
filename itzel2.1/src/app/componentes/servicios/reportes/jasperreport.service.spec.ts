import { TestBed } from '@angular/core/testing';

import { JasperreportService } from './jasperreport.service';

describe('JasperreportService', () => {
  let service: JasperreportService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(JasperreportService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

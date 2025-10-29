import { TestBed } from '@angular/core/testing';

import { ReportesjrService } from './reportesjr.service';

describe('ReportesjrService', () => {
  let service: ReportesjrService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ReportesjrService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

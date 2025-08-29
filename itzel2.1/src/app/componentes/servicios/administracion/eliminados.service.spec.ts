import { TestBed } from '@angular/core/testing';

import { EliminadosService } from './eliminados.service';

describe('EliminadosService', () => {
  let service: EliminadosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(EliminadosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

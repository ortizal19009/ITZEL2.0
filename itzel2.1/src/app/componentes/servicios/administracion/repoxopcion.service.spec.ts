import { TestBed } from '@angular/core/testing';

import { RepoxopcionService } from './repoxopcion.service';

describe('RepoxopcionService', () => {
  let service: RepoxopcionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RepoxopcionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

import { TestBed } from '@angular/core/testing';

import { DefinirService } from './definir.service';

describe('DefinirService', () => {
  let service: DefinirService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DefinirService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

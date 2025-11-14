import { TestBed } from '@angular/core/testing';

import { ArtimoviService } from './artimovi.service';

describe('ArtimoviService', () => {
  let service: ArtimoviService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ArtimoviService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

import { TestBed } from '@angular/core/testing';

import { TiptranService } from './tiptran.service';

describe('TiptranService', () => {
  let service: TiptranService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TiptranService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

import { TestBed } from '@angular/core/testing';

import { IfinanService } from './ifinan.service';

describe('IfinanService', () => {
  let service: IfinanService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(IfinanService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

import { TestBed } from '@angular/core/testing';

import { ArtixpedidoService } from './artixpedido.service';

describe('ArtixpedidoService', () => {
  let service: ArtixpedidoService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ArtixpedidoService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

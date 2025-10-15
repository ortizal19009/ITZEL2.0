import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiPedidoComponent } from './modi-pedido.component';

describe('ModiPedidoComponent', () => {
  let component: ModiPedidoComponent;
  let fixture: ComponentFixture<ModiPedidoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiPedidoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiPedidoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

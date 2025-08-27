import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiCuenta } from './modi-cuenta';

describe('ModiCuenta', () => {
  let component: ModiCuenta;
  let fixture: ComponentFixture<ModiCuenta>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiCuenta]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiCuenta);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

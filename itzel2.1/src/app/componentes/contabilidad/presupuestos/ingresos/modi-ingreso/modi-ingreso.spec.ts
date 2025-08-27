import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiIngreso } from './modi-ingreso';

describe('ModiIngreso', () => {
  let component: ModiIngreso;
  let fixture: ComponentFixture<ModiIngreso>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiIngreso]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiIngreso);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoCuenta } from './info-cuenta';

describe('InfoCuenta', () => {
  let component: InfoCuenta;
  let fixture: ComponentFixture<InfoCuenta>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoCuenta]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoCuenta);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddCuenta } from './add-cuenta';

describe('AddCuenta', () => {
  let component: AddCuenta;
  let fixture: ComponentFixture<AddCuenta>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddCuenta]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddCuenta);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

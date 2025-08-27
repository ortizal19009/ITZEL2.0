import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddIngreso } from './add-ingreso';

describe('AddIngreso', () => {
  let component: AddIngreso;
  let fixture: ComponentFixture<AddIngreso>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddIngreso]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddIngreso);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

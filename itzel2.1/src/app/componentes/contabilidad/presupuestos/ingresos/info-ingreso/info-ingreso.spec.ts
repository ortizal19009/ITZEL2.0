import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoIngreso } from './info-ingreso';

describe('InfoIngreso', () => {
  let component: InfoIngreso;
  let fixture: ComponentFixture<InfoIngreso>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoIngreso]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoIngreso);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

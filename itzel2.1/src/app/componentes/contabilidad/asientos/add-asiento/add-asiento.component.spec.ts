import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddAsientoComponent } from './add-asiento.component';

describe('AddAsientoComponent', () => {
  let component: AddAsientoComponent;
  let fixture: ComponentFixture<AddAsientoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddAsientoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddAsientoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

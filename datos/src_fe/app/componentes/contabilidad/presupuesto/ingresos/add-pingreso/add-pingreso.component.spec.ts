import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddPingresoComponent } from './add-pingreso.component';

describe('AddPingresoComponent', () => {
  let component: AddPingresoComponent;
  let fixture: ComponentFixture<AddPingresoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddPingresoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddPingresoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

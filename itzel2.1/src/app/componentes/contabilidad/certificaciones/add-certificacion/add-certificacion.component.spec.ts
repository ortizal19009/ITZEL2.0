import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddCertificacionComponent } from './add-certificacion.component';

describe('AddCertificacionComponent', () => {
  let component: AddCertificacionComponent;
  let fixture: ComponentFixture<AddCertificacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddCertificacionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddCertificacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

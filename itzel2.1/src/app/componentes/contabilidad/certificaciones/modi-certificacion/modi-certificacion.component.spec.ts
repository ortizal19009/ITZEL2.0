import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiCertificacionComponent } from './modi-certificacion.component';

describe('ModiCertificacionComponent', () => {
  let component: ModiCertificacionComponent;
  let fixture: ComponentFixture<ModiCertificacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiCertificacionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiCertificacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

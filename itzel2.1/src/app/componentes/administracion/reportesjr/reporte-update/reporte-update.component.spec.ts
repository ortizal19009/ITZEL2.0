import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReporteUpdateComponent } from './reporte-update.component';

describe('ReporteUpdateComponent', () => {
  let component: ReporteUpdateComponent;
  let fixture: ComponentFixture<ReporteUpdateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReporteUpdateComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReporteUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

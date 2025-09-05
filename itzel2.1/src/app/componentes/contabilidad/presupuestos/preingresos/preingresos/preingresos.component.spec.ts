import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PreingresosComponent } from './preingresos.component';

describe('PreingresosComponent', () => {
  let component: PreingresosComponent;
  let fixture: ComponentFixture<PreingresosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PreingresosComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PreingresosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

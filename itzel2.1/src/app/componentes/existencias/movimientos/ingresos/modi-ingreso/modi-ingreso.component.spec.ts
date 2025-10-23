import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiIngresoComponent } from './modi-ingreso.component';

describe('ModiIngresoComponent', () => {
  let component: ModiIngresoComponent;
  let fixture: ComponentFixture<ModiIngresoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiIngresoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiIngresoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiPingresoComponent } from './modi-pingreso.component';

describe('ModiPingresoComponent', () => {
  let component: ModiPingresoComponent;
  let fixture: ComponentFixture<ModiPingresoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiPingresoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiPingresoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

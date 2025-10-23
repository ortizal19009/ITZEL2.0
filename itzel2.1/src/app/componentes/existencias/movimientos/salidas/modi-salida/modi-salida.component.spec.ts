import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiSalidaComponent } from './modi-salida.component';

describe('ModiSalidaComponent', () => {
  let component: ModiSalidaComponent;
  let fixture: ComponentFixture<ModiSalidaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiSalidaComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiSalidaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

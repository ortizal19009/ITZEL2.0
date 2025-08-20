import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiCuentaComponent } from './modi-cuenta.component';

describe('ModiCuentaComponent', () => {
  let component: ModiCuentaComponent;
  let fixture: ComponentFixture<ModiCuentaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiCuentaComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiCuentaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

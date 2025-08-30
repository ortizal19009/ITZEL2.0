import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiProyectoComponent } from './modi-proyecto.component';

describe('ModiProyectoComponet', () => {
  let component: ModiProyectoComponent;
  let fixture: ComponentFixture<ModiProyectoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiProyectoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiProyectoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

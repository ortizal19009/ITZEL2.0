import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImpProyectoComponent } from './imp-proyecto.component';

describe('ImpProyecto', () => {
  let component: ImpProyectoComponent;
  let fixture: ComponentFixture<ImpProyectoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ImpProyectoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ImpProyectoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

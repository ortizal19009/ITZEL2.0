import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoProyectoComponent } from './info-proyecto.component';

describe('InfoProyectoComponent', () => {
  let component: InfoProyectoComponent;
  let fixture: ComponentFixture<InfoProyectoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoProyectoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoProyectoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

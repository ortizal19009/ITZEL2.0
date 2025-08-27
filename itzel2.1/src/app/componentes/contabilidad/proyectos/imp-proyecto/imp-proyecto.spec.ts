import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImpProyecto } from './imp-proyecto';

describe('ImpProyecto', () => {
  let component: ImpProyecto;
  let fixture: ComponentFixture<ImpProyecto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ImpProyecto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ImpProyecto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoProyecto } from './info-proyecto';

describe('InfoProyecto', () => {
  let component: InfoProyecto;
  let fixture: ComponentFixture<InfoProyecto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoProyecto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoProyecto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

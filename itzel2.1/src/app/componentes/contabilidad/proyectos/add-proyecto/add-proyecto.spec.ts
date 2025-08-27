import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddProyecto } from './add-proyecto';

describe('AddProyecto', () => {
  let component: AddProyecto;
  let fixture: ComponentFixture<AddProyecto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddProyecto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddProyecto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

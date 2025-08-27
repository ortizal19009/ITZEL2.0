import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiProyecto } from './modi-proyecto';

describe('ModiProyecto', () => {
  let component: ModiProyecto;
  let fixture: ComponentFixture<ModiProyecto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiProyecto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiProyecto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

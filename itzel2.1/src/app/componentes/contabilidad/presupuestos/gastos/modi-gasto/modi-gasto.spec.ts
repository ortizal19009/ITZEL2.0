import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiGasto } from './modi-gasto';

describe('ModiGasto', () => {
  let component: ModiGasto;
  let fixture: ComponentFixture<ModiGasto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiGasto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiGasto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoGasto } from './info-gasto';

describe('InfoGasto', () => {
  let component: InfoGasto;
  let fixture: ComponentFixture<InfoGasto>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoGasto]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoGasto);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

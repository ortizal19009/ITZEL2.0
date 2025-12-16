import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImpReportejrComponent } from './imp-reportejr.component';

describe('ImpReportejr', () => {
  let component: ImpReportejrComponent;
  let fixture: ComponentFixture<ImpReportejrComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ImpReportejrComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ImpReportejrComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

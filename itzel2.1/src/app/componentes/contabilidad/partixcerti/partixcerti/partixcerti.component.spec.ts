import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PartixcertiComponent } from './partixcerti.component';

describe('PartixcertiComponent', () => {
  let component: PartixcertiComponent;
  let fixture: ComponentFixture<PartixcertiComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PartixcertiComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PartixcertiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

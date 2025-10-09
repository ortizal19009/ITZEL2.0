import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddBenextranComponent } from './add-benextran.component';

describe('AddBenextranComponent', () => {
  let component: AddBenextranComponent;
  let fixture: ComponentFixture<AddBenextranComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddBenextranComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddBenextranComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

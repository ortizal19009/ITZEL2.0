import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddIfinanComponent } from './add-ifinan.component';

describe('AddIfinanComponent', () => {
  let component: AddIfinanComponent;
  let fixture: ComponentFixture<AddIfinanComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddIfinanComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddIfinanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

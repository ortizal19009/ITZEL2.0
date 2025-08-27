import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddIfinan } from './add-ifinan';

describe('AddIfinan', () => {
  let component: AddIfinan;
  let fixture: ComponentFixture<AddIfinan>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddIfinan]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddIfinan);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

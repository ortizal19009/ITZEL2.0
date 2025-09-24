import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddReintegroComponent } from './add-reintegro.component';

describe('AddReintegroComponent', () => {
  let component: AddReintegroComponent;
  let fixture: ComponentFixture<AddReintegroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddReintegroComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddReintegroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

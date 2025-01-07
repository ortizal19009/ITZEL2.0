import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddEstrfucComponent } from './add-estrfuc.component';

describe('AddEstrfucComponent', () => {
  let component: AddEstrfucComponent;
  let fixture: ComponentFixture<AddEstrfucComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddEstrfucComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddEstrfucComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

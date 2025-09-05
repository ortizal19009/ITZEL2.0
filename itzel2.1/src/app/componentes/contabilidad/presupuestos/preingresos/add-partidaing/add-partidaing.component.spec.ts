import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddPartidaingComponent } from './add-partidaing.component';

describe('AddPartidaingComponent', () => {
  let component: AddPartidaingComponent;
  let fixture: ComponentFixture<AddPartidaingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddPartidaingComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddPartidaingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

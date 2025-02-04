import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddPgastoComponent } from './add-pgasto.component';

describe('AddPgastoComponent', () => {
  let component: AddPgastoComponent;
  let fixture: ComponentFixture<AddPgastoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddPgastoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddPgastoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

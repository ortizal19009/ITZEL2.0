import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddCuentaComponent } from './add-cuenta.component';

describe('AddCuentaComponent', () => {
  let component: AddCuentaComponent;
  let fixture: ComponentFixture<AddCuentaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddCuentaComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddCuentaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

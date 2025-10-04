import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddTransaccionComponent } from './add-transaccion.component';

describe('AddTransaccionComponent', () => {
  let component: AddTransaccionComponent;
  let fixture: ComponentFixture<AddTransaccionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddTransaccionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddTransaccionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

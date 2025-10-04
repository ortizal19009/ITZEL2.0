import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiTransaccionComponent } from './modi-transaccion.component';

describe('ModiTransaccionComponent', () => {
  let component: ModiTransaccionComponent;
  let fixture: ComponentFixture<ModiTransaccionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiTransaccionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiTransaccionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

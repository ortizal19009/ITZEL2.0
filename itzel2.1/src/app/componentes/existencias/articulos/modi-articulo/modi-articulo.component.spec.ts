import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiArticuloComponent } from './modi-articulo.component';

describe('ModiArticuloComponent', () => {
  let component: ModiArticuloComponent;
  let fixture: ComponentFixture<ModiArticuloComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiArticuloComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiArticuloComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

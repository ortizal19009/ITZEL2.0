import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiPgastoComponent } from './modi-pgasto.component';

describe('ModiPgastoComponent', () => {
  let component: ModiPgastoComponent;
  let fixture: ComponentFixture<ModiPgastoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiPgastoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiPgastoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

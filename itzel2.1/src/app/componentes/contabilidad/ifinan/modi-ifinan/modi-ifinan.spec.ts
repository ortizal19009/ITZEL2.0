import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiIfinan } from './modi-ifinan';

describe('ModiIfinan', () => {
  let component: ModiIfinan;
  let fixture: ComponentFixture<ModiIfinan>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiIfinan]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiIfinan);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

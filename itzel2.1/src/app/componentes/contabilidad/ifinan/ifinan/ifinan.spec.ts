import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Ifinan } from './ifinan';

describe('Ifinan', () => {
  let component: Ifinan;
  let fixture: ComponentFixture<Ifinan>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Ifinan]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Ifinan);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

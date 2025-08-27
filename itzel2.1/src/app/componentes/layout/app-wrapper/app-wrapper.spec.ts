import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppWrapper } from './app-wrapper';

describe('AppWrapper', () => {
  let component: AppWrapper;
  let fixture: ComponentFixture<AppWrapper>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppWrapper]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppWrapper);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

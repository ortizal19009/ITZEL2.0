import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EstrfuncComponent } from './estrfunc.component';

describe('EstrfuncComponent', () => {
  let component: EstrfuncComponent;
  let fixture: ComponentFixture<EstrfuncComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EstrfuncComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EstrfuncComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

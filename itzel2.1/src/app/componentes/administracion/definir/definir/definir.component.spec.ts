import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DefinirComponent } from './definir.component';

describe('DefinirComponent', () => {
  let component: DefinirComponent;
  let fixture: ComponentFixture<DefinirComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DefinirComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DefinirComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiIfinanComponent } from './modi-ifinan.component';

describe('ModiIfinanComponent', () => {
  let component: ModiIfinanComponent;
  let fixture: ComponentFixture<ModiIfinanComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiIfinanComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiIfinanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

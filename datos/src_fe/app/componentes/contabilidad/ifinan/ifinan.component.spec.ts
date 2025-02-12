import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IfinanComponent } from './ifinan.component';

describe('IfinanComponent', () => {
  let component: IfinanComponent;
  let fixture: ComponentFixture<IfinanComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [IfinanComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(IfinanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

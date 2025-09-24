import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModiReintegroComponent } from './modi-reintegro.component';

describe('ModiReintegroComponent', () => {
  let component: ModiReintegroComponent;
  let fixture: ComponentFixture<ModiReintegroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ModiReintegroComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ModiReintegroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

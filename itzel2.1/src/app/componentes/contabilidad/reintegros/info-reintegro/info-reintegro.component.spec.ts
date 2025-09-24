import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoReintegroComponent } from './info-reintegro.component';

describe('InfoReintegroComponent', () => {
  let component: InfoReintegroComponent;
  let fixture: ComponentFixture<InfoReintegroComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoReintegroComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoReintegroComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoPgastoComponent } from './info-pgasto.component';

describe('InfoPgastoComponent', () => {
  let component: InfoPgastoComponent;
  let fixture: ComponentFixture<InfoPgastoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoPgastoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InfoPgastoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

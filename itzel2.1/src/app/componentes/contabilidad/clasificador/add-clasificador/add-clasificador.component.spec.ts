import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddClasificadorComponent } from './add-clasificador.component';

describe('AddClasificadorComponent', () => {
  let component: AddClasificadorComponent;
  let fixture: ComponentFixture<AddClasificadorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddClasificadorComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddClasificadorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

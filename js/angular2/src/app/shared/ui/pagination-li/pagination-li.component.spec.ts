import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PaginationLiComponent } from './pagination-li.component';

describe('PaginationLiComponent', () => {
  let component: PaginationLiComponent;
  let fixture: ComponentFixture<PaginationLiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PaginationLiComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaginationLiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

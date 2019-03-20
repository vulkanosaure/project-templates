import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ScrollBlockComponent } from './scroll-block.component';

describe('ScrollBlockComponent', () => {
  let component: ScrollBlockComponent;
  let fixture: ComponentFixture<ScrollBlockComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ScrollBlockComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ScrollBlockComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

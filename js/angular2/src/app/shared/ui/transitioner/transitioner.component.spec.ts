import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TransitionerComponent } from './transitioner.component';

describe('TransitionerComponent', () => {
  let component: TransitionerComponent;
  let fixture: ComponentFixture<TransitionerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TransitionerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TransitionerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

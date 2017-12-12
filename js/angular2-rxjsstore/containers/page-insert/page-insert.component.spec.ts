import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PageInsertComponent } from './page-insert.component';

describe('PageInsertComponent', () => {
  let component: PageInsertComponent;
  let fixture: ComponentFixture<PageInsertComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PageInsertComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PageInsertComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should be created', () => {
    expect(component).toBeTruthy();
  });
});

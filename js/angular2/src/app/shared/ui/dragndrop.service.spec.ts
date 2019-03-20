import { TestBed, inject } from '@angular/core/testing';

import { DragndropService } from './dragndrop.service';

describe('DragndropService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DragndropService]
    });
  });

  it('should be created', inject([DragndropService], (service: DragndropService) => {
    expect(service).toBeTruthy();
  }));
});

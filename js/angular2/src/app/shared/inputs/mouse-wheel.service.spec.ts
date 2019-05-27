import { TestBed, inject } from '@angular/core/testing';

import { MouseWheelService } from './mouse-wheel.service';

describe('MouseWheelService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MouseWheelService]
    });
  });

  it('should be created', inject([MouseWheelService], (service: MouseWheelService) => {
    expect(service).toBeTruthy();
  }));
});

import { TestBed, inject } from '@angular/core/testing';

import { InfoScrollService } from './info-scroll.service';

describe('InfoScrollService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [InfoScrollService]
    });
  });

  it('should be created', inject([InfoScrollService], (service: InfoScrollService) => {
    expect(service).toBeTruthy();
  }));
});

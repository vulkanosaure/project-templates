import { TestBed, inject } from '@angular/core/testing';

import { TurnBasedService } from './turn-based.service';

describe('TurnBasedService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TurnBasedService]
    });
  });

  it('should be created', inject([TurnBasedService], (service: TurnBasedService) => {
    expect(service).toBeTruthy();
  }));
});

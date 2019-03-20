import { TestBed, inject } from '@angular/core/testing';

import { RouterEventService } from './router-event.service';

describe('RouterEventService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [RouterEventService]
    });
  });

  it('should be created', inject([RouterEventService], (service: RouterEventService) => {
    expect(service).toBeTruthy();
  }));
});

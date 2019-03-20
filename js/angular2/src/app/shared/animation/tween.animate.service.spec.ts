import { TestBed, inject } from '@angular/core/testing';

import { TweenAnimateService } from './tween.animate.service';

describe('TweenAnimateService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TweenAnimateService]
    });
  });

  it('should be created', inject([TweenAnimateService], (service: TweenAnimateService) => {
    expect(service).toBeTruthy();
  }));
});

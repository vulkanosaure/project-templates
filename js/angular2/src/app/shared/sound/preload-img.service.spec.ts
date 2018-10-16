import { TestBed, inject } from '@angular/core/testing';

import { PreloadImgService } from './preload-img.service';

describe('PreloadImgService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PreloadImgService]
    });
  });

  it('should be created', inject([PreloadImgService], (service: PreloadImgService) => {
    expect(service).toBeTruthy();
  }));
});

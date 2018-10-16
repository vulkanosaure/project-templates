import { TestBed, inject } from '@angular/core/testing';

import { SoundPlayerService } from './sound-player.service';

describe('SoundPlayerService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SoundPlayerService]
    });
  });

  it('should be created', inject([SoundPlayerService], (service: SoundPlayerService) => {
    expect(service).toBeTruthy();
  }));
});

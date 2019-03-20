import { TestBed, inject } from '@angular/core/testing';

import { DslAnimateService } from './dsl.service';
import { AnimType, AnimArgs } from './animation.interface';
import { AnimateBase } from './animate.base.service';

describe('DslAnimateService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DslAnimateService]
    });
  });

  it('should be created', inject([DslAnimateService], (service: DslAnimateService) => {
		expect(service).toBeTruthy();
		
		
	}));
	
	
	
	it('should allow options shortcut with inheritance', inject([DslAnimateService], (service: DslAnimateService) => {
		
		let options:AnimArgs = service.getOptions({timeIn:400}, AnimType.FADE);
		expect(options.timeIn).toEqual(400);
		
		AnimateBase.addKeyOptions('test', {timeIn: 255});
		
		let output:AnimArgs = service.getOptions('test', AnimType.FADE);
		expect(output.timeIn).toEqual(255);
		//check inheritance
		expect(output.timeOut).toEqual(0.2);
		
		
  }));
	
	
});

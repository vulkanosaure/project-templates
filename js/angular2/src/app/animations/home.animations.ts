import { query, transition, trigger, group, useAnimation, animate, animation, animateChild, style, stagger, sequence } from '@angular/animations';
import { dsl } from './app.animations';
import { DslAnimateService } from '../shared/animation/dsl.service';
import { AnimateBase } from '../shared/animation/animate.base.service';
import { AnimType, Easing } from '../shared/animation/animation.interface';


/*
decorator :
animations: [xAnimations],
declarations :
@HostBinding('@animations') private animations;
*/



dsl.reset();
export const homeAnimation = [
	
  trigger('animations', [
		
    transition(':enter', group([
			
			query('.dsl_zoom', dsl.zoomIn(0.9, {})),
			query('.dsl_left1', dsl.slideIn(0.3, {dir: 'right', distanceIn:350, timeIn: 0.4, useMargin:false})),
			query('.dsl_left2', dsl.slideIn(0.1, {dir: 'right', distanceIn:350, timeIn: 0.4, useMargin:false})),
			query('.dsl_right', dsl.slideIn(0.3, {dir: 'left', distanceIn:350, timeIn: 0.4, useMargin:true})),
			
		])),
		
		transition(':leave', group([
			
			query('.dsl_fade', dsl.reset().fadeOut()),
		])),
		
		
  ])
];
